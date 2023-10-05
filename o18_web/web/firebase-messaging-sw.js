importScripts("https://www.gstatic.com/firebasejs/9.15.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/9.15.0/firebase-messaging.js");

// Initialize the Firebase app in the service worker by passing
// the generated configuration to the initializeApp function
firebase.initializeApp({
    apiKey: "",
    authDomain: "",
    databaseURL: "",
    projectId: "",
    storageBucket: "",
    messagingSenderId: "",
    appId: "",
    measurementId: ""
});

const messaging = firebase.messaging();

// Optional:
messaging.onBackgroundMessage((m) => {
    console.log("onBackgroundMessage", m);
});