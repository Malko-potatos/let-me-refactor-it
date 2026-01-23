# Design System

## Atmosphere
**Focused, Airy, Industrial-Chic**
The interface serves as a clean, well-lit workspace. It feels like a high-end workshop: organized, precise, and devoid of clutter. Interactions are physics-based, with elements settling into place with satisfying weight, reinforcing the connection between the digital inventory and physical reality.

## Color Palette

### Primary (Structural)
- **Deep Slate (#2C3E50)**: Used for primary actions, headers, and structural anchors. Solid and reliable.
- **Steel Grey (#95A5A6)**: Secondary text and borders. The metal of the machine.

### Accent (Interaction)
- **Precision Blue (#3498DB)**: Active states, focus rings, and primary buttons. Clear and directive.
- **Signal Amber (#F39C12)**: Warnings or attention-seeking elements.
- **Validation Green (#27AE60)**: Success states, confirming actions.

### Canvas & Surface
- **Workshop White (#FFFFFF)**: Main surfaces and cards.
- **Vapor Grey (#F4F6F7)**: Backgrounds, providing the "Airy" feel.

### Text
- **Ink Black (#2C3E50)**: Primary content.
- **Muted Graphite (#7F8C8D)**: Secondary labels and metadata.

## Typography
**Font Family:** Inter or System Sans-Serif (Clean, legible, tabular figures for data).

- **Display Headline:** 24px / SemiBold (Tracking: -0.5px). Used for `login_header`.
- **Section Title:** 18px / Medium. Used for `header_title`.
- **Body Regular:** 16px / Regular. Standard inputs and text.
- **Body Small:** 14px / Regular. Secondary info like SKU.
- **Button Label:** 16px / Medium (Uppercase optional).

## Spacing & Layout
**Grid Unit:** 8px base.

- **Tight (8px)**: Related elements within a component (e.g., label to input).
- **Comfortable (16px)**: Standard separation between form elements.
- **Spacious (24px - 32px)**: Section breaks, breathing room around the content area.

## Elevation & Shadows
- **Level 0 (Flat)**: Backgrounds.
- **Level 1 (Card)**: `0 2px 4px rgba(0,0,0,0.05)`. Subtle lift for list items (`item_card_template`).
- **Level 2 (Active/Modal)**: `0 4px 12px rgba(0,0,0,0.1)`. Dropdowns or floating actions.

## Motion
- **Entrance:** Elements cascade in with a slight vertical slide (10px -> 0px) and opacity fade.
- **Interaction:** Buttons press down (scale 0.98) instantly.
- **Transition:** 300ms cubic-bezier(0.4, 0.0, 0.2, 1).
