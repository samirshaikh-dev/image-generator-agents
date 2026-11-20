# Prompt v1 — MEE-2026-0006

- **Format:** `careers-hero-4-3` (`4:3`, `1440x1080`)
- **Style Lock:** `meelte-flat-vector-v1`
- **Text Mode:** `overlay_after_generation` (clean vector graphic symbols only, zero lettering or fake words)

---

## Concept 1: Team & Neighbourhood Collaboration (Primary)

### Positive Prompt

```text
A small diverse collaborative team of three colleagues in their late twenties gathered around an open modern laptop on a desk, smiling and pointing at the screen; behind them, a stylized neighbourhood street map backdrop with floating location pins, small café and shop silhouette icons, and floating rounded milestone cards showing a checkmark, a lightbulb, and a rocket.

Polished 2D commercial vector illustration for a modern retail brand.
Flat vector shapes with subtle gradients for depth.
Smooth clean edges, minimal outlines in a darker shade of each shape's fill.
Friendly characters with expressive simplified faces and rounded,
slightly exaggerated proportions (head-to-body 1:5.5).
Simplified recognisable objects and environments, three depth planes only.
Soft single-direction shadows at low opacity, restrained highlights.
Limited intentional palette: warm orange, deep purple, soft lavender,
dark charcoal, white.
Clear single focal point, uncluttered background, generous negative space.
Bold editorial advertising composition, playful and approachable.
No text, no lettering, no signage copy.

Composition: Centered balanced focal grouping filling the middle 60% of a 4:3 canvas. The team collaborating over the laptop sits in the midground plane at 50% width and 52% height. The background plane features a subtle circular ambient glow and a faint stylized neighbourhood grid with small shop and café outlines. In the foreground plane, three rounded milestone cards (checkmark, lightbulb, rocket) and two location pins float softly around the team. Generous negative space along all perimeter edges; outer 5% safe margins kept completely clean.

Palette: deep purple (#743BAA) on the team leader's jacket, laptop base, map path lines, and primary location pin; vibrant warm orange (#FEA711) on the colleague's sweater, the floating rocket body, lightbulb filament glow, and card highlight badges; soft lavender (#F4EFFD) on the circular glow and seamless background field; crisp clean white (#FFFFFF) on laptop screen surface, floating card faces, and symbol glyphs; dark charcoal (#171923) on subtle outlines, hair silhouettes, and desk surface. Deep purple and warm orange dominate together as the primary brand pair.

Text: No text, no letters, no words, no sentences, no typography, no fake words, no numbers, no watermarks, no logos anywhere on the laptop screen, cards, or background. Only clean, minimal geometric iconography (rocket glyph, lightbulb silhouette, checkmark, location pin).
```

### Negative Prompt

```text
photorealism, realistic photograph, 3D render, glossy reflections, skeuomorphism, dark background, clutter, distorted hands, extra fingers, missing fingers, deformed anatomy, blurry faces, garbled text, fake words, numbers, typography, lettering, signage copy, watermark, logo, cyan, teal, red, neon colors, low quality, busy scene, messy wires
```

### Parameters
- **Model:** `gemini-3-pro-image` (or Midjourney v6 `--ar 4:3 --stylize 150 --style raw`)
- **Dimensions:** 1440 × 1080 (Native 4:3)

---

## Concept 2: Tech, Devices & Floating Milestone Cards (Alternative / Safe AI Tool Option)

### Positive Prompt

```text
A modern open laptop and an upright smartphone placed neatly on a clean wooden desk, surrounded by floating rounded milestone cards displaying a clean code bracket symbol, a local discovery pin, a friendly speech bubble, a miniature launching rocket, and a steaming coffee cup.

Polished 2D commercial vector illustration for a modern retail brand.
Flat vector shapes with subtle gradients for depth.
Smooth clean edges, minimal outlines in a darker shade of each shape's fill.
Friendly characters with expressive simplified faces and rounded,
slightly exaggerated proportions (head-to-body 1:5.5).
Simplified recognisable objects and environments, three depth planes only.
Soft single-direction shadows at low opacity, restrained highlights.
Limited intentional palette: warm orange, deep purple, soft lavender,
dark charcoal, white.
Clear single focal point, uncluttered background, generous negative space.
Bold editorial advertising composition, playful and approachable.
No text, no lettering, no signage copy.

Composition: Symmetrical, centered tech cluster on a 4:3 canvas. The open laptop rests slightly angled at center-left with the smartphone adjacent at center-right in the midground plane. Five rounded milestone cards hover gracefully around the devices in the foreground plane with soft vertical drop shadows. A warm circular ambient glow radiates behind the cluster in the background plane. Perimeter borders remain spacious and empty with outer 5% safe margins preserved.

Palette: deep purple (#743BAA) on the laptop shell, phone casing, coffee mug, and primary location pin; vibrant warm orange (#FEA711) on the floating rocket, chat bubble, card border accents, and notification badge; soft lavender (#F4EFFD) on the radial glow and seamless canvas background; crisp white (#FFFFFF) on card faces, screen panels, and icon glyphs; dark charcoal (#171923) on desk edge, keyboard plane, and crisp outlines. Deep purple and warm orange dominate together as the primary brand pair.

Text: No text, no lettering, no fake code, no numbers, no words, no watermark, no logo. Clean geometric glyphs only (code brackets < />, location pin teardrop, rocket silhouette, speech bubble, coffee cup).
```

### Negative Prompt

```text
photorealism, realistic photograph, 3D render, glossy reflections, skeuomorphism, dark background, clutter, people, humans, figures, hands, garbled text, fake words, numbers, typography, lettering, signage copy, watermark, logo, cyan, teal, red, neon colors, low quality, messy desk
```

### Parameters
- **Model:** `gemini-nano-banana-2.1` or `gemini-3-pro-image`
- **Dimensions:** 1440 × 1080 (Native 4:3)
