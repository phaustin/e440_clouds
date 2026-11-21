# Customizing the look and feel of the MyST site via `myst.yml`

This list comes from the `book-theme` template that the build downloaded to
`_build/templates/site/myst/book-theme/template.yml` (mystmd v1.13.0).

**Note:** `hide_branding: true` in the current `myst.yml` isn't an option this
theme recognizes, so it has no effect. The "Made with MyST" sidebar footer goes
away when you put your own content in the `primary_sidebar_footer` part
(section 3).

## 1. Theme choice (`site.template`)

- `book-theme` (current): a left sidebar with the table of contents, plus a
  right-hand outline. It suits course notes.
- `article-theme`: a single-article layout with a margin column for figures
  and notes. It's better for a paper-style page.
- You can also point `template:` at a local path or a git URL to use a forked
  theme.

## 2. `site.options`: the main controls

```yaml
site:
  template: book-theme
  options:
    # Branding
    logo: images/logo.png
    logo_dark: images/logo_dark.png   # used in dark mode
    logo_text: EOSC 440               # text next to the logo
    logo_url: https://...             # defaults to the site root
    logo_alt: Course logo
    favicon: images/favicon.ico

    # Custom CSS: the most powerful option
    style: css/custom.css

    # Show or hide layout pieces
    hide_toc: false            # left sidebar
    hide_outline: false        # right "on this page" outline
    outline_maxdepth: 2        # heading depth in that outline (1–6)
    hide_breadcrumbs: true
    hide_title_block: false
    hide_authors: false
    hide_footer_links: false   # previous/next links
    hide_search: false

    # Behaviour
    folders: true              # URLs follow your folder structure
    numbered_references: true  # [1] citations instead of (Author, Year)
    internal_domains: "*.ubc.ca"   # links here open in the same tab, with no external icon
    redirects:
      - "old-page:new-page"

    # Analytics and social
    analytics_plausible: example.com
    analytics_google: G-XXXX
    twitter: handle
```

## 3. Parts: put your own content into the layout

Each part is a Markdown file:

```yaml
site:
  parts:
    footer: parts/footer.md                    # site-wide footer
    primary_sidebar_footer: parts/sidebar.md   # replaces "Made with MyST"
    navbar_end: parts/navbar.md                # right end of the top navbar
```

## 4. Custom CSS (`options.style`)

Fonts, colours, widths and spacing all come from this file. The theme is built
on Tailwind, so the reliable approach is to inspect an element in your
browser's dev tools and target its class. For example:

```css
/* css/custom.css */
body { font-family: "Source Serif 4", Georgia, serif; }
article h1, article h2 { color: #002145; }   /* UBC blue */
.myst-admonition { border-radius: 6px; }
```

## 5. Top navbar and action buttons

```yaml
site:
  nav:
    - title: Syllabus
      url: /syllabus
    - title: Resources
      children:
        - title: Canvas
          url: https://canvas.ubc.ca
  actions:
    - title: GitHub
      url: https://github.com/phaustin/e440_clouds
```

## 6. Per-page settings (in a page's frontmatter)

You can override some of these options for a single page:

```yaml
---
site:
  hide_outline: true
  hide_toc: true
---
```

The `project`-level `numbering:` settings (for equations, figures and headings)
also change how pages look.

## 7. Beyond this

If options and CSS aren't enough, you can fork `jupyter-book/myst-theme` and
point `template:` at your fork. That gives you full React/Remix control over
the layout, but it takes much more work.

To see the option list for your installed version at any time, run
`myst templates list --site` or read the `template.yml` above.
