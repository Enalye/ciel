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
        ThemeData _themeData;
    }

    static {
        void setTheme(ThemeData themeData) {
            _themeData = themeData;
            _etabli.ui.dispatchEvent("theme");
        }
    }

    /// Ctor
    this(uint windowWidth, uint windowHeight, string windowTitle = "Ciel") {
        enforce(!_isInstanciated, "une seule instance de Ciel peut exister");
        _isInstanciated = true;

        _etabli = new Etabli(windowWidth, windowHeight, windowTitle);
    }
}
