self.addEventListener('push', (event) => { 
    const notificationData = JSON.parse(event.data.text())

    const option = {
        title: notificationData.title,
        body: notificationData.body,
        // icon: notificationData.icon
    }

    event.waitUntil(
        self.registration.showNotification(notificationData.title, option)
    )
})