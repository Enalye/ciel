/** 
 * Copyright: Enalye
 * License: Zlib
 * Authors: Enalye
 */
module ciel.window;

import std.exception : enforce;
import etabli;

struct Theme {
    Font font;
    Color background;
    Color surface;
    Color container;
    Color foreground;
    Color neutral;
    Color accent;
    Color danger;
    Color onNeutral;
    Color onAccent;
    Color onDanger;
    float corner;
}

final class Ciel {
    private static {
        bool _isInstanciated;
        Etabli _etabli;
        Theme _theme;
    }

    static {
        Font getFont() {
            return _theme.font;
        }

        Color getBackground() {
            return _theme.background;
        }

        Color getSurface() {
            return _theme.surface;
        }

        Color getContainer() {
            return _theme.container;
        }

        Color getForeground() {
            return _theme.foreground;
        }

        Color getNeutral() {
            return _theme.neutral;
        }

        Color getAccent() {
            return _theme.accent;
        }

        Color getDanger() {
            return _theme.danger;
        }

        Color getOnNeutral() {
            return _theme.onNeutral;
        }

        Color getOnAccent() {
            return _theme.onAccent;
        }

        Color getOnDanger() {
            return _theme.onDanger;
        }

        float getCorner() {
            return _theme.corner;
        }

        Vec2f size() {
            return cast(Vec2f) Etabli.window.size();
        }

        float width() {
            return Etabli.window.width();
        }

        float height() {
            return Etabli.window.height();
        }

        void addUI(UIElement element) {
            _etabli.ui.addUI(element);
        }

        void clearUI() {
            _etabli.ui.clearUI();
        }

        void pushModalUI(UIElement element) {
            _etabli.ui.pushModalUI(element);
        }

        void popModalUI() {
            _etabli.ui.popModalUI();
        }
    }

    /// Init
    this(uint windowWidth, uint windowHeight, Theme delegate() themeFunc, string windowTitle = "Ciel") {
        enforce(!_isInstanciated, "une seule instance de Ciel peut exister");
        _isInstanciated = true;

        _etabli = new Etabli(windowWidth, windowHeight, windowTitle);

        _theme = themeFunc();
        _etabli.renderer.color = _theme.background;
    }

    void run() {
        _etabli.run();
    }
}
