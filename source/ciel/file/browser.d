/** 
 * Copyright: Enalye
 * License: Zlib
 * Authors: Enalye
 */
module ciel.file.browser;

import etabli;
import ciel.button;
import ciel.input;
import ciel.panel;
import ciel.window;
import ciel.navigation;

final class FileBrowser : Modal {
    private {
        TextField _uriField, _searchField;
        //VList _list; VContentView VScrollbar
    }

    this() {
        setSize(Vec2f(700f, 500f));

        GhostButton exitBtn = new GhostButton("X");
        exitBtn.setAlign(UIAlignX.right, UIAlignY.top);
        exitBtn.setPosition(Vec2f(4f, 4f));
        addUI(exitBtn);

        HBox headerBox = new HBox;
        headerBox.setAlign(UIAlignX.left, UIAlignY.top);
        headerBox.setPosition(Vec2f(4f, 4f));
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
        _uriField.setSize(Vec2f(300f, _uriField.getHeight()));
        _uriField.setPosition(Vec2f(50f, 4f));
        headerBox.addUI(_uriField);

        _searchField = new TextField;
        _searchField.setAlign(UIAlignX.left, UIAlignY.top);
        _searchField.setSize(Vec2f(150f, _uriField.getHeight()));
        _searchField.setPosition(Vec2f(50f, 4f));
        headerBox.addUI(_searchField);

        HBox footerBox = new HBox;
        footerBox.setAlign(UIAlignX.right, UIAlignY.bottom);
        footerBox.setPosition(Vec2f(4f, 4f));
        footerBox.setSpacing(4f);
        addUI(footerBox);

        auto cancelBtn = new SecondaryButton("Annuler");
        cancelBtn.addEventListener("click", { remove(); });
        footerBox.addUI(cancelBtn);

        auto createBtn = new PrimaryButton("Créer");
        footerBox.addUI(createBtn);

        VList _list = new VList;
        _list.setAlign(UIAlignX.center, UIAlignY.center);
        _list.setSize(Vec2f(300f, 300f));
        addUI(_list);
    }
}
