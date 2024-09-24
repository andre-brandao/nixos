import { dependencies, sh } from "lib/utils"

class Idle extends Service {
    static {
        Service.register(this, {}, {
            "idle": ["string"],
        })
    }

    #idle = "idle"

    get idle() { return this.#idle }

    #toggle() {
        if (!dependencies("matcha"))
            return

        sh(["matcha", "-t"])
    }

    #setIdle(idle: string) {
        this.#idle = idle.startsWith("Starting") ? "not idle" : "idle"
        this.changed("idle")
    }


    readonly toggle = () => { this.#toggle() }

    constructor() {
        super()

        if (!dependencies("matcha"))
            return this


        const proc = Utils.subprocess(
            ["matcha", "-d"],
            stdout => {
                Utils.notify({
                    summary: "Idle Status",
                    body: stdout,
                })
                this.#setIdle(stdout)
            },
            stderr => {
                Utils.notify({
                    summary: "Idle Status",
                    body: stderr,
                })
                this.#setIdle(stderr)
            },
        )
        print(proc)
    }
}

export default new Idle
