/** 
 * Copyright: Enalye
 * License: Zlib
 * Authors: Enalye
 */
module ciel.scrollbar.hscrollbar;

import etabli;
import ciel.window;

final class HScrollbar : Scrollbar {
    private {
        Capsule _background, _handle;
    }

    this() {
        setSize(Vec2f(0f, 9f));
        setSizeLock(false, true);

        _background = Capsule.fill(getSize());
        _background.anchor = Vec2f.zero;
        _background.color = Ciel.getNeutral();
        addImage(_background);

        _handle = Capsule.fill(getSize());
        _handle.anchor = Vec2f.zero;
        _handle.color = Ciel.getAccent();
        addImage(_handle);

        addEventListener("size", &_onSize);
        addEventListener("handlePosition", &_onHandlePosition);
        addEventListener("handleSize", &_onHandleSize);
    }

    protected override float _getScrollLength() const {
        return getWidth();
    }

    protected override float _getScrollMousePosition() const {
        return getMousePosition().x;
    }

    private void _onHandlePosition() {
        _handle.position.x = getHandlePosition();
    }

    private void _onHandleSize() {
        _handle.size = Vec2f(getHandleSize(), getHeight());
    }

    private void _onSize() {
        _background.size = getSize();
        _handle.size = Vec2f(getHandleSize(), getHeight());
    }
}
