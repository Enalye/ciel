/** 
 * Copyright: Enalye
 * License: Zlib
 * Authors: Enalye
 */
module ciel.file.browser;

import std.file, std.path, std.string;
import etabli;
import ciel.button;
import ciel.input;
import ciel.panel;
import ciel.window;
import ciel.navigation;

final class FileBrowser : Modal {
    private {
        TextField _uriField, _searchField;
        VList _list;
        FileItem[] _items;
        FileItem _selectedItem;
        UIElement _validateBtn;
        string _value;
    }

    @property {
        string value() const {
            return _value;
        }
    }

    this() {
        setSize(Vec2f(700f, 500f));

        GhostButton exitBtn = new GhostButton("X");
        exitBtn.setAlign(UIAlignX.right, UIAlignY.top);
        exitBtn.setPosition(Vec2f(4f, 4f));
        exitBtn.addEventListener("click", &remove);
        addUI(exitBtn);

        HBox headerBox = new HBox;
        headerBox.setAlign(UIAlignX.left, UIAlignY.top);
        headerBox.setPosition(Vec2f(8f, 8f));
        headerBox.setSpacing(4f);
        addUI(headerBox);

        GhostButton prevBtn = new GhostButton("<");
        headerBox.addUI(prevBtn);

        GhostButton nextBtn = new GhostButton(">");
        headerBox.addUI(nextBtn);

        GhostButton upBtn = new GhostButton("^");
        headerBox.addUI(upBtn);

        _uriField = new TextField;
        _uriField.setAlign(UIAlignX.left, UIAlignY.top);
        _uriField.setSize(Vec2f(450f, _uriField.getHeight()));
        headerBox.addUI(_uriField);

        GhostButton reloadBtn = new GhostButton("R");
        headerBox.addUI(reloadBtn);

        {
            HBox searchBox = new HBox;
            searchBox.setAlign(UIAlignX.left, UIAlignY.bottom);
            searchBox.setPosition(Vec2f(16f, 8f));
            searchBox.setSpacing(8f);
            addUI(searchBox);

            Label searchLabel = new Label("Rechercher:", Ciel.getFont());
            searchLabel.color = Ciel.getOnNeutral();
            searchBox.addUI(searchLabel);

            _searchField = new TextField;
            _searchField.setAlign(UIAlignX.left, UIAlignY.top);
            _searchField.setSize(Vec2f(150f, _uriField.getHeight()));
            searchBox.addUI(_searchField);
        }

        HBox footerBox = new HBox;
        footerBox.setAlign(UIAlignX.right, UIAlignY.bottom);
        footerBox.setPosition(Vec2f(8f, 8f));
        footerBox.setSpacing(8f);
        addUI(footerBox);

        auto cancelBtn = new NeutralButton("Annuler");
        cancelBtn.addEventListener("click", &remove);
        footerBox.addUI(cancelBtn);

        _validateBtn = new AccentButton("Ouvrir");
        _validateBtn.isEnabled = false;
        footerBox.addUI(_validateBtn);

        _list = new VList;
        _list.setAlign(UIAlignX.right, UIAlignY.top);
        _list.setSize(Vec2f(getWidth() - 16f, 400f));
        _list.setPosition(Vec2f(8f, 50f));
        addUI(_list);

        _reloadDir();
    }

    private void _onValidate() {
        if (!_selectedItem)
            return;

        _value = _selectedItem.path;
        dispatchEvent("value", false);
    }

    package void validateItem(FileItem item_) {
        _selectedItem = item_;
        _value = _selectedItem.path;
        dispatchEvent("value", false);
    }

    package void selectItem(FileItem item_) {
        _selectedItem = item_;
        foreach (item; _items) {
            item._updateValue(item == item_);
        }
        _validateBtn.isEnabled = true;
        _validateBtn.addEventListener("click", &_onValidate);
    }

    private void _reloadDir() {
        _value = "";
        _list.clearList();
        _validateBtn.isEnabled = false;
        _validateBtn.removeEventListener("click", &_onValidate);
        _selectedItem = null;
        foreach (file; dirEntries(getcwd(), SpanMode.shallow)) {
            FileItem element = new FileItem(file, this);
            _items ~= element;
            _list.addList(element);
        }
    }
}

private final class FileItem : UIElement {
    private {
        Rectangle _rectangle;
        Label _label;
        FileBrowser _browser;
        bool _isSelected;
        string _path;
    }

    @property {
        string path() const {
            return _path;
        }
    }

    this(string path_, FileBrowser browser) {
        _path = path_;
        _browser = browser;
        setSize(Vec2f(getParentWidth() - 9f, 32f));

        _rectangle = Rectangle.fill(getSize());
        _rectangle.anchor = Vec2f.zero;
        _rectangle.color = Ciel.getForeground();
        _rectangle.isVisible = false;
        addImage(_rectangle);

        _label = new Label(baseName(_path), Ciel.getFont());
        _label.setAlign(UIAlignX.left, UIAlignY.center);
        _label.setPosition(Vec2f(8f, 0f));
        _label.color = Ciel.getOnNeutral();
        addUI(_label);

        addEventListener("click", &_onClick);
        addEventListener("mouseenter", &_onMouseEnter);
        addEventListener("mouseleave", &_onMouseLeave);
    }

    private void _onClick() {
        _browser.selectItem(this);

        InputEvent.MouseButton ev = Etabli.ui.input.asMouseButton();
        if (ev.clicks > 1) {
            _browser.validateItem(this);
        }
    }

    package void _updateValue(bool value) {
        _isSelected = value;

        if (_isSelected) {
            removeEventListener("mouseenter", &_onMouseEnter);
            removeEventListener("mouseleave", &_onMouseLeave);
            _isSelected = true;
            _rectangle.color = Ciel.getAccent();
            _label.color = Ciel.getOnAccent();
            _rectangle.isVisible = true;
        }
        else {
            _isSelected = false;
            _rectangle.color = Ciel.getForeground();
            _label.color = Ciel.getOnNeutral();
            _rectangle.isVisible = isHovered();
            addEventListener("mouseenter", &_onMouseEnter);
            addEventListener("mouseleave", &_onMouseLeave);
        }
    }

    private void _onMouseEnter() {
        _rectangle.isVisible = true;
    }

    private void _onMouseLeave() {
        _rectangle.isVisible = false;
    }
}
