# Design Systems

**This document describes the design systems used across frontend products.**

AI reads this before implementing any frontend work to ensure UI consistency.

Humans read this to understand design patterns, component usage, and visual standards.

**Keep this document synchronized with your actual design implementation.**

---

## Overview

### Purpose

This document defines:
- Shared design tokens (colors, typography, spacing)
- Component libraries and usage patterns
- Per-product design variations
- Component documentation standards (props, variants, do/don't)

### When This Document Applies

**Frontend work is detected when ANY of these paths are modified:**
- `/web/*`, `/frontend/*` (website)
- `/admin/*` (admin-panel)
- `/android/*` (android)
- `/ios/*` (ios)
- Any `.tsx`, `.jsx`, `.vue`, `.svelte` files
- Any `.css`, `.scss`, `.less`, `.styled.ts` files
- Any component directories matching `**/components/**`

---

## Shared Design Principles

### Color System

**Primary Palette:**

| Token | Hex | Usage |
|-------|-----|-------|
| `--color-primary` | #3B82F6 | Primary actions, links |
| `--color-primary-hover` | #2563EB | Hover states |
| `--color-primary-light` | #DBEAFE | Backgrounds, highlights |
| `--color-secondary` | #6B7280 | Secondary text, icons |
| `--color-success` | #10B981 | Success states |
| `--color-warning` | #F59E0B | Warning states |
| `--color-error` | #EF4444 | Error states |
| `--color-info` | #3B82F6 | Info states |

**Neutral Palette:**

| Token | Hex | Usage |
|-------|-----|-------|
| `--color-white` | #FFFFFF | Backgrounds |
| `--color-gray-50` | #F9FAFB | Subtle backgrounds |
| `--color-gray-100` | #F3F4F6 | Borders, dividers |
| `--color-gray-200` | #E5E7EB | Disabled states |
| `--color-gray-500` | #6B7280 | Secondary text |
| `--color-gray-700` | #374151 | Body text |
| `--color-gray-900` | #111827 | Headings |

### Typography

**Font Families:**

| Token | Value | Usage |
|-------|-------|-------|
| `--font-sans` | 'Inter', sans-serif | All UI text |
| `--font-mono` | 'JetBrains Mono', monospace | Code, technical content |

**Font Sizes:**

| Token | Size | Line Height | Usage |
|-------|------|-------------|-------|
| `--text-xs` | 12px | 16px | Labels, captions |
| `--text-sm` | 14px | 20px | Secondary text, buttons |
| `--text-base` | 16px | 24px | Body text |
| `--text-lg` | 18px | 28px | Subheadings |
| `--text-xl` | 20px | 28px | Section headers |
| `--text-2xl` | 24px | 32px | Page titles |
| `--text-3xl` | 30px | 36px | Hero text |

**Font Weights:**

| Token | Weight | Usage |
|-------|--------|-------|
| `--font-normal` | 400 | Body text |
| `--font-medium` | 500 | Buttons, labels |
| `--font-semibold` | 600 | Subheadings |
| `--font-bold` | 700 | Headings |

### Spacing System

**Base Unit:** 4px

| Token | Value | Usage |
|-------|-------|-------|
| `--space-1` | 4px | Tight spacing |
| `--space-2` | 8px | Icon padding |
| `--space-3` | 12px | Button padding |
| `--space-4` | 16px | Card padding |
| `--space-6` | 24px | Section spacing |
| `--space-8` | 32px | Large gaps |
| `--space-12` | 48px | Page margins |
| `--space-16` | 64px | Section separators |

### Border Radius

| Token | Value | Usage |
|-------|-------|-------|
| `--radius-sm` | 4px | Small buttons, inputs |
| `--radius-md` | 8px | Cards, modals |
| `--radius-lg` | 12px | Large cards |
| `--radius-full` | 9999px | Pills, avatars |

### Shadows

| Token | Value | Usage |
|-------|-------|-------|
| `--shadow-sm` | 0 1px 2px rgba(0,0,0,0.05) | Subtle elevation |
| `--shadow-md` | 0 4px 6px rgba(0,0,0,0.1) | Cards, buttons |
| `--shadow-lg` | 0 10px 15px rgba(0,0,0,0.1) | Modals, dropdowns |

### Icons

**Icon Library:** Lucide Icons (https://lucide.dev)

**Icon Sizes:**

| Size | Value | Usage |
|------|-------|-------|
| `sm` | 16px | Inline with text |
| `md` | 20px | Buttons, inputs |
| `lg` | 24px | Standalone icons |
| `xl` | 32px | Feature icons |

---

## Component Documentation Format

**Every component MUST be documented with this format:**

```markdown
### ComponentName

**Purpose:** [One sentence describing what this component does]

**Location:** `[path/to/component]`

**Products:** `[website, admin-panel, android, ios]`

#### Props

| Prop | Type | Default | Required | Description |
|------|------|---------|----------|-------------|
| variant | 'primary' \| 'secondary' | 'primary' | No | Visual style |
| size | 'sm' \| 'md' \| 'lg' | 'md' | No | Size variant |
| disabled | boolean | false | No | Disabled state |

#### Variants

**Primary (default):**
- Blue background, white text
- Use for main actions

**Secondary:**
- Gray background, dark text
- Use for secondary actions

#### Usage Examples

**Basic Usage:**
```jsx
<Button>Click me</Button>
```

**With Props:**
```jsx
<Button variant="secondary" size="lg" disabled>
  Disabled Button
</Button>
```

#### Do / Don't

| Do | Don't |
|----|-------|
| Use primary for ONE main action per screen | Use multiple primary buttons together |
| Keep button text short (2-3 words) | Write long sentences in buttons |
| Use loading state for async actions | Disable button without feedback |

#### Accessibility

- Must have `aria-label` if icon-only
- Focus state must be visible
- Color contrast minimum 4.5:1
```

---

## Per-Product Design Systems

### Website (`/web/*`, `/frontend/*`)

**Design Language:** Modern, friendly, consumer-focused

**Primary Framework:** React with TailwindCSS

**Component Library:** Custom components built on Radix UI primitives

**Color Customizations:**
- Uses full color palette
- Dark mode: Planned (not implemented)

**Typography Customizations:**
- Hero sections use `--text-3xl` and above
- Maximum content width: 1280px

**Key Components:**

| Component | Location | Status |
|-----------|----------|--------|
| Button | `web/components/Button.tsx` | Needs docs |
| Input | `web/components/Input.tsx` | Needs docs |
| Card | `web/components/Card.tsx` | Needs docs |
| Modal | `web/components/Modal.tsx` | Needs docs |

---

### Admin Panel (`/admin/*`)

**Design Language:** Professional, dense, data-focused

**Primary Framework:** React with TailwindCSS

**Component Library:** Based on Shadcn/UI

**Color Customizations:**
- Muted palette (less saturated)
- More gray usage for data density

**Typography Customizations:**
- Smaller base font (`--text-sm` for tables)
- Tighter line heights for data views

**Key Components:**

| Component | Location | Status |
|-----------|----------|--------|
| DataTable | `admin/components/DataTable.tsx` | Needs docs |
| Sidebar | `admin/components/Sidebar.tsx` | Needs docs |
| StatsCard | `admin/components/StatsCard.tsx` | Needs docs |

---

### Android (`/android/*`)

**Design Language:** Material Design 3

**Primary Framework:** Jetpack Compose

**Component Library:** Material 3 components

**Color Customizations:**
- Uses Material You dynamic colors
- Mapped to shared palette tokens

**Typography Customizations:**
- Material Type Scale (Roboto)

**Key Components:**

| Component | Location | Status |
|-----------|----------|--------|
| AppButton | `android/ui/components/AppButton.kt` | Needs docs |
| AppCard | `android/ui/components/AppCard.kt` | Needs docs |

---

### iOS (`/ios/*`)

**Design Language:** Human Interface Guidelines

**Primary Framework:** SwiftUI

**Component Library:** Native SwiftUI components

**Color Customizations:**
- Uses SF Symbols color palette
- Mapped to shared palette tokens

**Typography Customizations:**
- SF Pro (system font)
- Dynamic Type support

**Key Components:**

| Component | Location | Status |
|-----------|----------|--------|
| PrimaryButton | `ios/Views/Components/PrimaryButton.swift` | Needs docs |
| AppCard | `ios/Views/Components/AppCard.swift` | Needs docs |

---

## Adding New Components

### Process

1. **Check if shared:** Does this component exist in another product?
2. **Follow naming:** Use consistent naming across products
3. **Document immediately:** Use the Component Template above
4. **Add to table:** Update the per-product component table
5. **Update this document:** Keep design-systems.md current

### Component Naming Conventions

| Type | Convention | Example |
|------|------------|---------|
| Button variants | `{Variant}Button` | `PrimaryButton`, `IconButton` |
| Input variants | `{Type}Input` | `TextInput`, `SearchInput` |
| Cards | `{Purpose}Card` | `StatsCard`, `ProfileCard` |
| Modals | `{Purpose}Modal` | `ConfirmModal`, `EditModal` |

---

## Growing This Document

### When to Update

**Add new section when:**
- New product is added
- New component category is introduced
- Design tokens are changed

**Add component documentation when:**
- Component is created
- Component is significantly modified
- Component is used across products

### What to Document

**Always document:**
- All reusable components
- All design tokens in use
- Product-specific patterns

**Don't document:**
- One-off page-specific layouts
- Trivial wrapper components
- Internal implementation details

---

## For AI: Using This Document

### Before Frontend Implementation

1. **Read this entire document** to understand design patterns
2. **Check per-product section** for specific guidelines
3. **Search for existing components** before creating new ones
4. **Follow naming conventions** and documentation format

### During Implementation

1. **Use design tokens** - Never hardcode colors, spacing, or typography
2. **Follow Do/Don't rules** - These prevent common mistakes
3. **Check accessibility** - Meet minimum contrast and ARIA requirements
4. **Update this document** - Add new components as you create them

### After Implementation

1. **Document new components** using the Component Template
2. **Update component tables** in per-product sections
3. **Add lessons learned** to lessons.md if design issues arose

---

## Document Maintenance

**This document is updated when:**
- Design tokens change (colors, typography, spacing)
- New components are created
- Products are added
- Component APIs change

**Keep this document accurate.** AI relies on it for consistent frontend development.
