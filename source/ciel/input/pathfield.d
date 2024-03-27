/** 
 * Copyright: Enalye
 * License: Zlib
 * Authors: Enalye
 */
module ciel.input.pathfield;

import etabli;
import ciel.navigation;
import ciel.window;
import ciel.input.textfield;
import std.path;

final class PathField : UIElement {
    private {
        RoundedRectangle _background, _outline;
        TextField _textField;
        Breadcrumbs _breadcrumbs;
        string _path;
        bool _isEditing;
    }

    @property {
        string value() const {
            return _path;
        }

        string value(string value_) {
            if (_path == value_)
                return _path;
            _path = value_;
            _reload();
            return _path;
        }
    }

    this(string path) {
        setSize(Vec2f(400f, 32f));

        _background = RoundedRectangle.fill(getSize(), Ciel.getCorner());
        _background.anchor = Vec2f.zero;
        _background.color = Ciel.getBackground();
        addImage(_background);

        _outline = RoundedRectangle.outline(getSize(), Ciel.getCorner(), 1f);
        _outline.anchor = Vec2f.zero;
        _outline.color = Ciel.getNeutral();
        addImage(_outline);

        _textField = new TextField;
        _textField.setAlign(UIAlignX.left, UIAlignY.center);
        _textField.setSize(getSize());

        _path = buildNormalizedPath(path);

        string[] parts;
        foreach (part; pathSplitter(_path)) {
            parts ~= part;
        }

        _breadcrumbs = new Breadcrumbs(parts, getWidth());
        _breadcrumbs.setAlign(UIAlignX.left, UIAlignY.center);
        addUI(_breadcrumbs);

        addEventListener("size", &_onSize);
        addEventListener("click", &_onClick);
        _breadcrumbs.addEventListener("value", &_onBreadcrumbs);
        _textField.addEventListener("validate", &_onTextField);
    }

    private void _onSize() {
        _background.size = getSize();
        _outline.size = getSize();
        _textField.setSize(getSize());
    }

    private void _onClick() {
        _isEditing = !_isEditing;

        if (_isEditing) {
            _breadcrumbs.remove();
            _background.isVisible = false;
            _outline.isVisible = false;
            _textField.value = _path;
            addUI(_textField);

            Etabli.ui.setFocus(_textField);

            addEventListener("clickoutside", &_onClickOut);
        }
        else {
            _textField.remove();
            _background.isVisible = true;
            _outline.isVisible = true;
            addUI(_breadcrumbs);

            removeEventListener("clickoutside", &_onClickOut);
        }
    }

    private void _reload() {
        _textField.value = _path;

        string[] parts;
        foreach (part; pathSplitter(_path)) {
            parts ~= part;
        }
        _breadcrumbs.value = parts;
    }

    private void _onBreadcrumbs() {
        string path_ = buildNormalizedPath(_breadcrumbs.value);

        if (_path == path_)
            return;

        _path = path_;

        dispatchEvent("value", false);
    }

    private void _onTextField() {
        bool isDirty;
        if (_path != _textField.value) {
            isDirty = true;
        }

        _path = _textField.value;

        if (isDirty) {
            string[] parts;
            foreach (part; pathSplitter(_path)) {
                parts ~= part;
            }
            _breadcrumbs.value = parts;
        }
        _onClick();

        if (isDirty) {
            dispatchEvent("value", false);
        }
    }

    private void _onClickOut() {
        _onClick();
    }
}
