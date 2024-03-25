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
        TextField _textField;
        Breadcrumbs _breadcrumbs;
        bool _isEditing;
    }

    this(string path) {
        setSize(Vec2f(200f, 32f));

        _textField = new TextField;
        _textField.setAlign(UIAlignX.left, UIAlignY.center);
        _textField.setSize(getSize());

        path = buildNormalizedPath(path);

        string[] parts;
        foreach (part; pathSplitter(path)) {
            parts ~= part;
        }

        _breadcrumbs = new Breadcrumbs(parts, getWidth());
        _breadcrumbs.setAlign(UIAlignX.left, UIAlignY.center);
        addUI(_breadcrumbs);

        addEventListener("click", &_onClick);
    }

    private void _onClick() {
        _isEditing = !_isEditing;

        if (_isEditing) {
            _breadcrumbs.remove();
            addUI(_textField);

            addEventListener("clickoutside", &_onClickOut);
        }
        else {
            _textField.remove();
            addUI(_breadcrumbs);

            removeEventListener("clickoutside", &_onClickOut);
        }
    }

    private void _onClickOut() {
        _onClick();
    }

    private void _reloadBreadcrumb() {

    }
}
