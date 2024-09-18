import PanelButton from "../PanelButton"

import idle from "service/idle"

// import icons from "lib/icons"

export default () => {
    return PanelButton({
        class_name: "idle-inhibitor",
        child: Widget.Icon({
            icon: idle.bind("idle")
                .as(v => v === "idle" ? "dialog-error-symbolic" : "emblem-default-symbolic"),
        }),
        // child: Widget.Label({
        //     label: idle.bind("idle").as(v => v === "idle" ? "🌙" : "🌞"),
        // }),
        tooltip_text: idle.bind("idle").as(v => `${v}`),
        on_clicked: idle.toggle,
    })
}
