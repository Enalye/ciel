/** 
 * Copyright: Enalye
 * License: Zlib
 * Authors: Enalye
 */
module ciel.window;

import std.exception : enforce;
import etabli;
import ciel.theme;

final class Ciel {
    private {
        Etabli _etabli;
    }

    private static {
        bool _isInstanciated;
        Theme _theme;
    }

    static {
        void setTheme(Theme theme) {
            _theme = theme;
            _etabli.ui.dispatchEvent("theme");
            _etabli.renderer.color = _theme.getColor("background");
        }

        const(Theme) theme() {
            return _theme;
        }

        void addElement(UIElement element) {
            _etabli.ui.addElement(element);
        }

        void clearElements() {
            _etabli.ui.clearElements();
        }
    }

    /// Ctor
    this(uint windowWidth, uint windowHeight, string windowTitle = "Ciel") {
        enforce(!_isInstanciated, "une seule instance de Ciel peut exister");
        _isInstanciated = true;

        _etabli = new Etabli(windowWidth, windowHeight, windowTitle);
        _initThemes();
    }

    private void _initThemes() {
        Theme defaultTheme = new Theme;
        defaultTheme.setMode(Theme.Mode.light);

        defaultTheme.setColor("background", Color.fromHex(0xf6fcfe));
        defaultTheme.setColor("surface", Color.fromHex(0xcdedfa));
        defaultTheme.setColor("container", Color.fromHex(0x77b5fe));
        defaultTheme.setColor("primary", Color.fromHex(0x0077b6));
        defaultTheme.setColor("secondary", Color.fromHex(0x00b4d8));
        defaultTheme.setColor("neutral", Color.fromHex(0xaec2cb));
        defaultTheme.setColor("danger", Color.fromHex(0xf6b9c5));
        defaultTheme.setColor("onBackground", Color.fromHex(0x002263));
        defaultTheme.setColor("onSurface", Color.fromHex(0x002263));
        defaultTheme.setColor("onContainer", Color.fromHex(0x002263));
        defaultTheme.setColor("onPrimary", Color.fromHex(0xe2f8ff));
        defaultTheme.setColor("onSecondary", Color.fromHex(0xe2f8ff));
        defaultTheme.setColor("onNeutral", Color.fromHex(0x2c3134));
        defaultTheme.setColor("onDanger", Color.fromHex(0xd72b4d));

        defaultTheme.setFont("button", new TrueTypeFont(
            veraFontData, 24
        ));

        _theme = defaultTheme;
        _etabli.renderer.color = _theme.getColor("background");
    }

    void run() {
        _etabli.run();
    }
}
