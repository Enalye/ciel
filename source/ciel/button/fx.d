/** 
 * Copyright: Enalye
 * License: Zlib
 * Authors: Enalye
 */
module ciel.button.fx;

import etabli;
import ciel.window;

final class RippleEffect {
    private {
        class Ripple {
            Timer timer;
            float startRadius, radius;
            float startAlpha, alpha;
            Vec2f position = Vec2f.zero;
        }

        Circle _circle;

        Array!Ripple _ripples;

        Vec2f _position = Vec2f.zero;
        float _radius = 10f;

        Ripple _pressedRipple;
        bool _isPressed;
    }

    Color _color;

    this(float radius_) {
        _radius = radius_ * 2f;
        _ripples = new Array!Ripple;

        _circle = new Circle(_radius, true, 0f);
        _circle.blend = Blend.alpha;
        _circle.noCache = true;
        _circle.cache();
    }

    void onClick(Vec2f position) {
        _position = position;
        _isPressed = true;
        _pressedRipple = new Ripple;
        _pressedRipple.startRadius = _pressedRipple.radius = 10f;
        _pressedRipple.startAlpha = _pressedRipple.alpha = .26f;
        _pressedRipple.position = position;
        _pressedRipple.timer.start(30);
    }

    void onUnclick() {
        if (!_isPressed)
            return;
        _isPressed = false;

        _pressedRipple.timer.start(20);
        _pressedRipple.startRadius = _pressedRipple.radius;
        _pressedRipple.startAlpha = _pressedRipple.alpha;

        if (_ripples.full) {
            size_t index;
            int timer = 0;
            foreach (i, ripple; _ripples) {
                if (!ripple.timer.isRunning) {
                    index = i;
                    break;
                }
                if (ripple.timer.value > timer) {
                    timer = ripple.timer.value;
                    index = i;
                }
            }
            _ripples[index] = _pressedRipple;
        }
        else {
            _ripples.push(_pressedRipple);
        }
    }

    void update() {
        foreach (i, ripple; _ripples) {
            ripple.timer.update();
            if (!ripple.timer.isRunning) {
                _ripples.mark(i);
            }
            else {
                ripple.radius = lerp(ripple.startRadius, _radius,
                    easeOutQuad(ripple.timer.value01));
                ripple.alpha = lerp(ripple.startAlpha, 0f, easeOutSine(ripple.timer.value01));
            }
        }
        _ripples.sweep();

        if (_isPressed) {
            _pressedRipple.timer.update();

            _pressedRipple.position = _position;

            _pressedRipple.radius = lerp(_pressedRipple.startRadius, _radius,
                easeOutSine(_pressedRipple.timer.value01));
            /*_pressedRipple.alpha = lerp(_pressedRipple.startAlpha, 0.2f,
                easeOutSine(_pressedRipple.timer.value01));*/
        }
    }

    void onUpdate(Vec2f position) {
        _position = position;
    }

    void draw() {
        _circle.color = _color;

        foreach (ripple; _ripples) {
            _circle.radius = ripple.radius;
            _circle.alpha = ripple.alpha;
            _circle.draw(ripple.position);
        }

        if (_isPressed) {
            _circle.radius = _pressedRipple.radius;
            _circle.alpha = _pressedRipple.alpha;
            _circle.draw(_pressedRipple.position);
        }
    }
}

final class ButtonFx {
    private {
        UIElement _element;
        RoundedRectangle _mask;
        RippleEffect _rippleEffect;
        Color _color;
    }

    this(UIElement element) {
        _element = element;

        _mask = new RoundedRectangle(_element.getSize(), 8f, true, 0f);
        _mask.anchor = Vec2f.zero;
        _mask.blend = Blend.mask;

        _rippleEffect = new RippleEffect(_element.getSize().x);
    }

    void setColor(Color rgb) {
        HSLColor hsl = HSLColor.fromColor(rgb);
        hsl.s = hsl.s * 1.1f;
        hsl.l = hsl.l * 0.9f;
        _color = hsl.toColor();
    }

    void update() {
        _rippleEffect.update();
    }

    void draw() {
        Etabli.renderer.pushCanvas(cast(int) _element.getSize().x, cast(int) _element.getSize().y);

        _rippleEffect._color = Color.fromHex(0xffffff);
        _rippleEffect.draw();
        _mask.blend = Blend.mask;
        _mask.color = _color;
        _mask.alpha = 1f;
        _mask.draw(Vec2f.zero);

        Etabli.renderer.popCanvasAndDraw(Vec2f.zero, _element.getSize(), 0f,
            Vec2f.zero, _color, 1f);
    }

    void onClick(Vec2f position) {
        _rippleEffect.onClick(position);
    }

    void onUnclick() {
        _rippleEffect.onUnclick();
    }

    void onUpdate(Vec2f position) {
        _rippleEffect.onUpdate(position);
    }
}
