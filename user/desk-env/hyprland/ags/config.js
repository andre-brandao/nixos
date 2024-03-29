import { Bar } from "./widgets/topBar.js";
import { NotificationPopups } from "./widgets/notificationPopup.js";

App.config({
  style: "./style.css",
  windows: [Bar(), NotificationPopups()],
});

export {};
