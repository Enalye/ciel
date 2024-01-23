/** 
 * Copyright: Enalye
 * License: Zlib
 * Authors: Enalye
 */
module ciel.theme;

import std.exception : enforce;
import etabli;

private {
    int[] _teinteMenthe = [
        0x009343, 0x00b55a, 0x00c866, 0x00dc75, 0x00ee81, 0x00f494, 0x00fba6,
        0x77febf, 0xb5fed8, 0xe1fff0
    ];

    int[] teinteCiel = [
        0x008784, 0x00acb2, 0x00c1cb, 0x00d8e7, 0x00eafc, 0x00effb, 0x29f5fe,
        0x77fafe, 0xb2fbfd, 0xe0fefe
    ];

    int[] teinteRose = [
        0x8a0052, 0xb10058, 0xc7005b, 0xde0060, 0xef0062, 0xf3007c, 0xfa3096,
        0xfe77b6, 0xfeb0d4, 0xfeb0d4, 0xffe0ee
    ];

    int[] teinteVert = [
        0x009315, 0x00b823, 0x00cd2b, 0x00e434, 0x00f63d, 0x3efb57, 0x77fe7c,
        0xa7ffa5, 0xccffca, 0xebffea
    ];
}

final class Theme {
    enum Mode {
        light,
        dark
    }

    private {
        Mode _mode = Mode.light;
        Color[string] _colors;
        Font[string] _fonts;
    }

    @property {
        Mode mode() const {
            return _mode;
        }
    }

    Color getColor(string key) const {
        auto p = key in _colors;
        enforce(p, "couleur non-définie");
        return *p;
    }

    Font getFont(string key) const {
        auto p = key in _fonts;
        enforce(p, "police non-définie");
        return cast(Font) *p;
    }

    void setMode(Mode mode_) {
        _mode = mode_;
    }

    void setColor(string key, Color color) {
        _colors[key] = color;
    }

    void setFont(string key, Font font) {
        _fonts[key] = font;
    }
}
