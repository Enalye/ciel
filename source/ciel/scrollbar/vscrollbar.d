/** 
 * Copyright: Enalye
 * License: Zlib
 * Authors: Enalye
 */
module ciel.scrollbar.vscrollbar;

import etabli;
import ciel.window;

final class VScrollbar : Scrollbar {
    private {
        Capsule _background, _handle;
    }

    this() {
        setSize(Vec2f(9f, 0f));
        setSizeLock(true, false);

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
        return getHeight();
    }

    protected override float _getScrollMousePosition() const {
        return getMousePosition().y;
    }

    private void _onHandlePosition() {
        _handle.position.y = getHandlePosition();
    }

    private void _onHandleSize() {
        _handle.size = Vec2f(getWidth(), getHandleSize());
    }

    private void _onSize() {
        _background.size = getSize();
        _handle.size = Vec2f(getWidth(), getHandleSize());
    }
}
