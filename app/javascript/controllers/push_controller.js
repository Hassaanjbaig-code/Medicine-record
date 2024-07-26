import { Controller, fetch } from "@hotwired/stimulus"
import axios from "axios";

// Connects to data-controller="push"
export default class extends Controller {
  connect() {
    if ("Notification" in window) {
      Notification.requestPermission().then((prem) => {
        if (prem == "granted") {
          console.log("Permission is granted");
          this.registerServiceWorker();
        } else if (prem == "denied") {
          console.warn("Permission is denied");
        }
      });
    } else {
      console.warn("Notification not supported");
    }
  }

  registerServiceWorker() {
    const applicationServerKey = this.element.getAttribute("data-application-server-key");
    navigator.serviceWorker.register("service_worker.js").then((serviceWorkerRegister) => {
      serviceWorkerRegister.pushManager.getSubscription().then((existingSubscription) => {
        // console.log("This is the existingSubscription", existingSubscription);
        if (existingSubscription == null) {
          serviceWorkerRegister.pushManager.subscribe({
            userVisibleOnly: true,
            applicationServerKey: this.urlBase64ToUint8Array(applicationServerKey),
          }).then((subscription) => {
            this.saveSubscription(subscription);
          });
        }
      }).catch((existingSubscriptionError) => console.warn("This is the error of Existing Subscription", existingSubscriptionError));
    }).catch((error) => console.warn("Registration error", error));
  }

  urlBase64ToUint8Array(base64String) {
    const padding = '='.repeat((4 - base64String.length % 4) % 4);
    const base64 = (base64String + padding)
      .replace(/\-/g, '+')
      .replace(/_/g, '/');

    const rawData = window.atob(base64);
    const outputArray = new Uint8Array(rawData.length);

    for (let i = 0; i < rawData.length; ++i) {
      outputArray[i] = rawData.charCodeAt(i);
    }
    return outputArray;
  }

  async saveSubscription(subscription) {
    if (!subscription) {
      console.error("No subscription provided.");
      return;
    }
    try {
      const endpoint = subscription.endpoint;
      const p256dhKey = subscription.getKey("p256dh");
      const authKey = subscription.getKey("auth");

      if (!p256dhKey || !authKey) {
        console.warn("The p256dh and auth keys are unavailable");
        return;
      }

      const p256dh = btoa(String.fromCharCode.apply(null, new Uint8Array(p256dhKey)));
      const auth = btoa(String.fromCharCode.apply(null, new Uint8Array(authKey)));

      const payload = {
        endpoint: endpoint, p256db: p256dh, auth: auth
      }
      const response = await axios.post("/subscribe", payload, {
        headers: {
          "Content-Type": "application/json",
          Accept: "application/json",
          "X-CSRF-Token": document
            .querySelector('meta[name="csrf-token"]')
            .getAttribute("content"),
        }
      })
      if (response.ok == true) {
        console.log("It is created")
      }
    } catch (mainError) {
      console.warn("This is the error", mainError);
    }
  }

  PushNotification(){
    axios.get("/push")
  }
}
