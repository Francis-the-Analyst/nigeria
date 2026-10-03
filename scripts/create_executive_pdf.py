from pathlib import Path
import re

from reportlab.lib import colors
from reportlab.lib.enums import TA_LEFT
from reportlab.lib.pagesizes import A4
from reportlab.lib.styles import ParagraphStyle, getSampleStyleSheet
from reportlab.lib.units import mm
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.ttfonts import TTFont
from reportlab.platypus import (
    BaseDocTemplate,
    Frame,
    KeepTogether,
    ListFlowable,
    ListItem,
    PageTemplate,
    Paragraph,
    Spacer,
    Table,
    TableStyle,
)


ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "resumen_ejecutivo_nigeria_fase1.md"
OUTPUT = ROOT / "resumen_ejecutivo_nigeria_fase1.pdf"


def register_fonts():
    regular = Path(r"C:\Windows\Fonts\segoeui.ttf")
    bold = Path(r"C:\Windows\Fonts\segoeuib.ttf")
    if regular.exists() and bold.exists():
        pdfmetrics.registerFont(TTFont("SegoeUI", str(regular)))
        pdfmetrics.registerFont(TTFont("SegoeUI-Bold", str(bold)))
        return "SegoeUI", "SegoeUI-Bold"
    return "Helvetica", "Helvetica-Bold"


REGULAR, BOLD = register_fonts()


def inline_markup(value):
    value = value.strip()
    value = re.sub(r"\[([^\]]+)\]\(([^)]+)\)", r'<link href="\2" color="#39735b">\1</link>', value)
    value = re.sub(r"`([^`]+)`", r'<font name="Courier">\1</font>', value)
    value = re.sub(r"\*\*([^*]+)\*\*", r"<b>\1</b>", value)
    return value


def is_table_line(line):
    return line.strip().startswith("|") and line.strip().endswith("|")


def table_rows(lines):
    rows = []
    for line in lines:
        cells = [cell.strip() for cell in line.strip().strip("|").split("|")]
        if all(re.fullmatch(r":?-{3,}:?", cell) for cell in cells):
            continue
        rows.append([Paragraph(inline_markup(cell), styles["TableCell"]) for cell in cells])
    return rows


def make_table(lines):
    rows = table_rows(lines)
    if not rows:
        return Spacer(1, 2)
    rows[0] = [Paragraph(f"<b>{cell.text}</b>", styles["TableHeader"]) for cell in rows[0]]
    column_count = max(len(row) for row in rows)
    for row in rows:
        while len(row) < column_count:
            row.append(Paragraph("", styles["TableCell"]))
    widths = [((A4[0] - 34 * mm) / column_count)] * column_count
    table = Table(rows, colWidths=widths, repeatRows=1, hAlign="LEFT")
    table.setStyle(TableStyle([
        ("BACKGROUND", (0, 0), (-1, 0), colors.HexColor("#dceee5")),
        ("TEXTCOLOR", (0, 0), (-1, 0), colors.HexColor("#173a2a")),
        ("GRID", (0, 0), (-1, -1), 0.35, colors.HexColor("#b8c9c0")),
        ("VALIGN", (0, 0), (-1, -1), "TOP"),
        ("LEFTPADDING", (0, 0), (-1, -1), 5),
        ("RIGHTPADDING", (0, 0), (-1, -1), 5),
        ("TOPPADDING", (0, 0), (-1, -1), 5),
        ("BOTTOMPADDING", (0, 0), (-1, -1), 5),
    ]))
    return table


def build_story(markdown):
    lines = markdown.splitlines()
    story = []
    index = 0
    while index < len(lines):
        line = lines[index].strip()
        if not line:
            index += 1
            continue
        if line.startswith("# "):
            story.append(Paragraph(inline_markup(line[2:]), styles["CoverTitle"]))
            index += 1
            continue
        if line.startswith("## "):
            story.append(Spacer(1, 7))
            story.append(Paragraph(inline_markup(line[3:]), styles["SectionHeading"]))
            index += 1
            continue
        if line.startswith("### "):
            story.append(Spacer(1, 4))
            story.append(Paragraph(inline_markup(line[4:]), styles["SubHeading"]))
            index += 1
            continue
        if line.startswith("|"):
            table = []
            while index < len(lines) and is_table_line(lines[index]):
                table.append(lines[index])
                index += 1
            story.append(Spacer(1, 4))
            story.append(make_table(table))
            continue
        if line.startswith("- "):
            bullets = []
            while index < len(lines) and lines[index].strip().startswith("- "):
                bullets.append(ListItem(Paragraph(inline_markup(lines[index].strip()[2:]), styles["Body"]), leftIndent=10))
                index += 1
            story.append(ListFlowable(bullets, bulletType="bullet", start="circle", leftIndent=15))
            continue
        if re.match(r"^\d+\. ", line):
            numbered = []
            while index < len(lines) and re.match(r"^\d+\. ", lines[index].strip()):
                text = re.sub(r"^\d+\. ", "", lines[index].strip())
                numbered.append(ListItem(Paragraph(inline_markup(text), styles["Body"]), leftIndent=10))
                index += 1
            story.append(ListFlowable(numbered, bulletType="1", leftIndent=18))
            continue
        paragraph = [line]
        index += 1
        while index < len(lines) and lines[index].strip() and not re.match(r"^(#|\-|\d+\.|\|)", lines[index].strip()):
            paragraph.append(lines[index].strip())
            index += 1
        story.append(Paragraph(inline_markup(" ".join(paragraph)), styles["Body"]))
    return story


styles = getSampleStyleSheet()
styles.add(ParagraphStyle(name="CoverTitle", parent=styles["Title"], fontName=BOLD, fontSize=25, leading=29, textColor=colors.HexColor("#173a2a"), spaceAfter=9, alignment=TA_LEFT))
styles.add(ParagraphStyle(name="SectionHeading", parent=styles["Heading1"], fontName=BOLD, fontSize=16, leading=19, textColor=colors.HexColor("#28654a"), spaceBefore=8, spaceAfter=6))
styles.add(ParagraphStyle(name="SubHeading", parent=styles["Heading2"], fontName=BOLD, fontSize=11.5, leading=14, textColor=colors.HexColor("#28654a"), spaceBefore=6, spaceAfter=3))
styles.add(ParagraphStyle(name="Body", parent=styles["BodyText"], fontName=REGULAR, fontSize=8.8, leading=12.2, textColor=colors.HexColor("#24302a"), spaceAfter=6))
styles.add(ParagraphStyle(name="TableCell", parent=styles["BodyText"], fontName=REGULAR, fontSize=7.2, leading=9.2, textColor=colors.HexColor("#24302a")))
styles.add(ParagraphStyle(name="TableHeader", parent=styles["BodyText"], fontName=BOLD, fontSize=7.3, leading=9.2, textColor=colors.HexColor("#173a2a")))


def header_footer(canvas, document):
    canvas.saveState()
    width, height = A4
    canvas.setStrokeColor(colors.HexColor("#b8c9c0"))
    canvas.setLineWidth(0.45)
    canvas.line(17 * mm, height - 14 * mm, width - 17 * mm, height - 14 * mm)
    canvas.setFont(REGULAR, 7.5)
    canvas.setFillColor(colors.HexColor("#65736b"))
    canvas.drawString(17 * mm, height - 11 * mm, "COSENTINO NIGERIA · FASE 1")
    canvas.drawRightString(width - 17 * mm, 10 * mm, f"Página {document.page}")
    canvas.restoreState()


def main():
    markdown = SOURCE.read_text(encoding="utf-8")
    doc = BaseDocTemplate(str(OUTPUT), pagesize=A4, rightMargin=17 * mm, leftMargin=17 * mm, topMargin=21 * mm, bottomMargin=16 * mm, title="Cosentino Nigeria — Resumen ejecutivo Fase 1", author="Cosentino Nigeria")
    frame = Frame(doc.leftMargin, doc.bottomMargin, doc.width, doc.height, id="normal")
    doc.addPageTemplates([PageTemplate(id="main", frames=frame, onPage=header_footer)])
    doc.build(build_story(markdown))
    print(f"created {OUTPUT} ({OUTPUT.stat().st_size} bytes)")


if __name__ == "__main__":
    main()
