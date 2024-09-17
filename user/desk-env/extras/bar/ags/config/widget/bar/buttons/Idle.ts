import PanelButton from "../PanelButton"

import idle from "service/idle"

export default () => {
    return PanelButton({
        class_name: "idle-inhibitor",
        // child: Widget.Icon("system-run-symbolic"),
        child: Widget.Label({
            label: idle.bind("idle").as(v => v === "idle" ? "🌙" : "🌞"),
        }),
        tooltip_text: idle.bind("idle").as(v => `${v}`),
        on_clicked: idle.toggle,
    })
}
