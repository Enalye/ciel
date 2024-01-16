/** 
 * Copyright: Enalye
 * License: Zlib
 * Authors: Enalye
 */
module ciel.theme;

import etabli;

struct ThemeData {
    Color background;
    Color surface;
    Color onSurface;
    Color primary;
    Color primaryContainer;
    Color onPrimary;
    Color neutral;
}

private {
    ThemeData[] _themes;
}

void initThemes() {
    ThemeData defaultTheme = {
        background: Color.fromHex(0xa5d4ad), //
        surface: Color.fromHex(0xffffff), //
        onSurface: Color.fromHex(0x000000), //
        primary: Color.fromHex(0xa5d4ad), //
        primaryContainer: Color.fromHex(0x00baaa), //
        onPrimary: Color.fromHex(0x000000), //
        neutral: Color.fromHex(0xcecece)
    };

    /*ThemeData purpleTheme = {
        primary = Color.fromHex(0x6750A4);
        outline = Color.fromHex(0x79747E);
        onPrimary = Color.fromHex(0xFFFFFF);
        onSurface = Color.fromHex(0x1C1B1F);
    };*/

    _themes = [defaultTheme];
}

enum ThemeKey {
    background,
    surface,
    onSurface,
    primary,
    primaryContainer,
    onPrimary,
    neutral
}

int getThemesCount() {
    return cast(int) _themes.length;
}

private int getThemeId() {
    return 0;
}

Color getTheme(ThemeKey type) {
    int themeId = getThemeId();
    if (themeId >= _themes.length)
        themeId = 0;

    if (!_themes.length)
        return Color.white;

    ThemeData currentTheme = _themes[themeId];

    final switch (type) with (ThemeKey) {
    case background:
        return currentTheme.background;
    case surface:
        return currentTheme.surface;
    case onSurface:
        return currentTheme.onSurface;
    case primary:
        return currentTheme.primary;
    case primaryContainer:
        return currentTheme.primaryContainer;
    case onPrimary:
        return currentTheme.onPrimary;
    case neutral:
        return currentTheme.neutral;
    }
}
