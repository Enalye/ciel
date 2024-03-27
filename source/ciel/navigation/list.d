/** 
 * Copyright: Enalye
 * License: Zlib
 * Authors: Enalye
 */
module ciel.navigation.list;

import etabli;
import ciel.window;
import ciel.scrollbar;

abstract class List : UIElement {
    protected {
        Scrollbar _scrollbar;
        ContentView _contentView;
        Rectangle _background;
    }

    this() {
        _background = Rectangle.fill(getSize());
        _background.color = Ciel.getBackground();
        _background.anchor = Vec2f.zero;
        addImage(_background);

        addEventListener("size", &_onSize);
    }

    void addList(UIElement element) {
        _contentView.addUI(element);
    }

    void clearList() {
        _contentView.clearUI();
    }

    private void _onSize() {
        _background.size = getSize();
    }
}

final class HList : List {
    this() {
        HContentView contentView = new HContentView;
        contentView.setAlign(UIAlignX.left, UIAlignY.top);
        contentView.setChildAlign(UIAlignY.top);
        addUI(contentView);

        _contentView = contentView;

        _scrollbar = new HScrollbar;
        _scrollbar.setAlign(UIAlignX.left, UIAlignY.bottom);
        addUI(_scrollbar);

        addEventListener("size", &_onSize);
        addEventListener("wheel", &_onWheel);
        _contentView.addEventListener("contentSize", &_onUpdateContent);
        _scrollbar.addEventListener("handlePosition", &_onHandlePosition);
    }

    private void _onSize() {
        _scrollbar.setWidth(getWidth());
        _contentView.setSize(getSize() - Vec2f(0f, _scrollbar.getHeight()));
    }

    private void _onUpdateContent() {
        _scrollbar.setContentSize(_contentView.getContentWidth());
    }

    private void _onHandlePosition() {
        _contentView.setContentPosition(_scrollbar.getContentPosition());
    }

    private void _onWheel() {
        _scrollbar.removeEventListener("handlePosition", &_onHandlePosition);

        InputEvent.MouseWheel ev = Etabli.ui.input.asMouseWheel();
        _contentView.setContentPosition(_contentView.getContentPosition() - ev.wheel.sum() * 32f);
        _scrollbar.setContentPosition(_contentView.getContentPosition());

        _scrollbar.addEventListener("handlePosition", &_onHandlePosition);
    }
}

final class VList : List {
    this() {
        VContentView contentView = new VContentView;
        contentView.setAlign(UIAlignX.left, UIAlignY.top);
        contentView.setChildAlign(UIAlignX.left);
        addUI(contentView);

        _contentView = contentView;

        _scrollbar = new VScrollbar;
        _scrollbar.setAlign(UIAlignX.right, UIAlignY.top);
        addUI(_scrollbar);

        addEventListener("size", &_onSize);
        addEventListener("wheel", &_onWheel);
        _contentView.addEventListener("contentSize", &_onUpdateContent);
        _scrollbar.addEventListener("handlePosition", &_onHandlePosition);
    }

    private void _onSize() {
        _scrollbar.setHeight(getHeight());
        _contentView.setSize(getSize() - Vec2f(_scrollbar.getWidth(), 0f));
    }

    private void _onUpdateContent() {
        _scrollbar.setContentSize(_contentView.getContentHeight());
    }

    private void _onHandlePosition() {
        _contentView.setContentPosition(_scrollbar.getContentPosition());
    }

    private void _onWheel() {
        _scrollbar.removeEventListener("handlePosition", &_onHandlePosition);

        InputEvent.MouseWheel ev = Etabli.ui.input.asMouseWheel();
        _contentView.setContentPosition(_contentView.getContentPosition() - ev.wheel.sum() * 32f);
        _scrollbar.setContentPosition(_contentView.getContentPosition());

        _scrollbar.addEventListener("handlePosition", &_onHandlePosition);
    }
}
