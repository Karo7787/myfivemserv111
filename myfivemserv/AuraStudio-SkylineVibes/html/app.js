var resourceName = "aura-elevator";
if (window.GetParentResourceName) {
	resourceName = window.GetParentResourceName();
}

var elevator = null;

$(document).ready(function () {
    if (elevator != null) {
        elevator.pause();
    }
    elevator = new Howl({ src: ["sound/aura-elevator.mp3"] });
    elevator.volume(1.5);
});

const app = Vue.createApp({
	data() {
		return {
			general: {
				show: false,
				state: "x",
			},
		};
	},
	mounted() {
		window.addEventListener("message", (event) => {
			if (event.data.action == "closeElevator") {
				this.general.show = true;
				this.general.state = "closeDoor";
				elevator.play();
			} else if (event.data.action == "openElevator") {
				this.general.show = true;
				this.general.state = "openDoor";
			}
		});
	},
}).mount("#app");
