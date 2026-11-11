# Meelte Brand — Do / Don't Examples

Each pair is a real decision an agent will face. The failure is named so it can be caught in QA.

## 1. Dominant colour pair

**Do:** purple headline panel with an orange focal accent; lavender field behind.
**Don't:** all-orange creative with purple used as a small dot in a corner.

*Failure:* purple demoted to decoration. The brand reads as "orange brand", not Meelte.

## 2. Illustration style

**Do:** flat vector shopkeeper behind a counter, rounded proportions, minimal outlines, soft shadow under the counter.
**Don't:** photorealistic shopkeeper with shallow depth of field.

*Failure:* style drift into stock photography. Banned by `illustration.banned_treatments`.

## 3. Character design

**Do:** rounded, slightly exaggerated proportions; expressive simple face; hands simplified but present; consistent line weight.
**Don't:** anatomically detailed hands with individually rendered fingers and knuckle creases.

*Failure:* detail budget spent on the wrong area; also the most common AI artifact zone.

## 4. Headline length

**Do:** "Sell more, stress less."
**Don't:** "Discover how Meelte's integrated commerce platform helps local retailers unlock growth."

*Failure:* headline is a paragraph. Six words maximum; the second version is a supporting line at best.

## 5. Text rendering

**Do:** generate the illustration with a clean lavender header band, then overlay "Diwali Offer" in Poppins ExtraBold.
**Don't:** ask the model to render "Diwali Offer" and accept "Diwali Ofeer".

*Failure:* unverified in-image text. Brand name, price, date, and offer copy are always overlaid.

## 6. Logo placement

**Do:** full-colour logo bottom-left on the white footer band, 6% margin, clear space respected.
**Don't:** logo centred over the illustration at 40% width.

*Failure:* logo competes with the focal point and loses legibility.

## 7. Claim discipline

**Do:** "Get your shop online in minutes." (capability stated in brief)
**Don't:** "Join 50,000+ stores growing 3x faster."

*Failure:* invented statistics. `copy.claim_policy` forbids unsupplied numbers.

## 8. Negative space

**Do:** one subject, one headline, one supporting line, generous lavender margin.
**Don't:** five floating icons, three badges, a starburst, and a decorative border.

*Failure:* clutter. Every extra element reduces the message.

## 9. Aspect ratio adaptation

**Do:** recompose the 1:1 concept for 16:9 — purple panel left, illustration centre, CTA right.
**Don't:** place the square artwork on a blurred background and call it a banner.

*Failure:* forced layout. Adapt composition, not just canvas.

## 10. Tone

**Do:** "Your shop, open to the whole neighbourhood."
**Don't:** "Leverage omnichannel commerce to optimise your retail footprint."

*Failure:* enterprise jargon. Meelte speaks to the owner, not to a procurement team.

## 11. Festival treatment

**Do:** Diwali conveyed through string lights, mithai boxes, and warm lighting within the brand palette.
**Don't:** gold glitter textures, marigold-orange gradients, and a new festive red.

*Failure:* unapproved palette expansion. Festival feeling comes from props and light, not new hues.

## 12. Series consistency

**Do:** same character family, same outline weight, same footer band, new scene and new headline.
**Don't:** each post in the series with a different illustration style and a different layout grid.

*Failure:* the series reads as unrelated ads. See `campaign-series-consistency`.

## Quick self-check

Before shipping, ask:

1. Squint — are orange and purple both still present?
2. Is there exactly one focal point?
3. Would a stranger read the message in under three seconds?
4. Is every word spelled correctly, especially "Meelte"?
5. Is every number and claim traceable to the brief?
