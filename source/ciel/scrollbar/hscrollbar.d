/** 
 * Copyright: Enalye
 * License: Zlib
 * Authors: Enalye
 */
module ciel.scrollbar.hscrollbar;

import etabli;
import ciel.window;

abstract class Scrollbar : UIElement {

}

/// Réglette horizontale
final class HScrollbar : Scrollbar {
    private {
        Capsule _background, _handle;
    }

    /// Ctor
    this(float windowSize) {
        setSize(Vec2f(getParentWidth(), 9f));
        setAlign(UIAlignX.center, UIAlignY.bottom);

        _background = Capsule.fill(getSize());
        _background.anchor = Vec2f.zero;
        _background.color = Ciel.getNeutral();
        addImage(_background);

        _handle = Capsule.fill(Vec2f((getWidth() / windowSize) * getWidth(), 9f));
        _handle.anchor = Vec2f(.5f, 0f);
        _handle.color = Ciel.getAccent();
        addImage(_handle);

import std.stdio;
        writeln(getWidth(), ",", windowSize);


        _handle.position = Vec2f(100f, 0f);
    }
}
