/** 
 * Copyright: Enalye
 * License: Zlib
 * Authors: Enalye
 */
module ciel.menu.bar;

import etabli;
import ciel.panel;
import ciel.window;
import ciel.menu.list;
import ciel.menu.button;

class MenuBar : UIElement {
    private {
        HBox _box;
        Container _container;
        MenuList _list;
        float _barHeight = 35f;
        uint _currentListId;

        MenuButton[] _menuButtons;
        MenuList[] _menuLists;
    }

    this() {
        setAlign(UIAlignX.left, UIAlignY.top);

        setSize(Vec2f(Ciel.window.width, _barHeight));

        _container = new Container;
        addUI(_container);

        _box = new HBox;
        _box.setAlign(UIAlignX.left, UIAlignY.center);
        _box.setMargin(Vec2f(8f, 4f));
        addUI(_box);

        foreach (id, key; ["Fichier", "Édition", "Projet", "Affichage"]) {
            add(key, "sosis");
            add(key, "chocolaté");
            addSeparator(key);
            add(key, "camembert");
        }

        addEventListener("register", &_onSize);
        addEventListener("parentSize", &_onSize);
        addEventListener("size", { _container.setSize(getSize()); });
    }

    private MenuList _getList(string menuName) {
        MenuList list;

        for (uint i; i < _menuLists.length; ++i) {
            if (_menuLists[i].name == menuName) {
                list = _menuLists[i];
                break;
            }
        }
        if (!list) {
            list = new MenuList(this, cast(uint) _menuLists.length, menuName);
            MenuButton btn = new MenuButton(this, cast(uint) _menuLists.length, menuName);
            _box.addUI(btn);

            _menuLists ~= list;
            _menuButtons ~= btn;
        }
        return list;
    }

    UIElement add(string menuName, string itemName) {
        MenuList list = _getList(menuName);
        return list.add(itemName);
    }

    void addSeparator(string menuName) {
        MenuList list = _getList(menuName);
        list.addSeparator();
    }

    private void _onSize() {
        UIElement parent = getParent();
        if (parent) {
            setSize(Vec2f(parent.getWidth(), _barHeight));
        }
        else {
            setSize(Vec2f(Ciel.window.width, _barHeight));
        }
    }

    package void removeList(uint id) {
        if (_currentListId == id)
            return;

        if (_list) {
            _list.startRemove();
            _list = null;
        }
    }

    package void leaveMenu(uint id) {
        _currentListId = uint.max;
    }

    package void switchMenu(uint id) {
        _currentListId = id;

        if (!_list) {
            return;
        }

        if (_list && _list.id == id) {
            return;
        }
        toggleMenu(id);
    }

    package void toggleMenu(uint id) {
        if (_list) {
            uint listId = _list.id;
            _list.startRemove();
            _list = null;
            if (listId == id) {
                return;
            }
        }

        _list = _menuLists[id];
        _list.setPosition(getPosition() + _menuButtons[id].getPosition() + Vec2f(0f, getHeight()));
        _list.runState("visible");

        UIElement parent = getParent();
        if (parent) {
            parent.addUI(_list);
        }
        else {
            Ciel.addUI(_list);
        }
    }
}
