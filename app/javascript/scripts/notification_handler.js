const NOTIFICATION_ENDPOINT = 'http://127.0.0.1:3000/notifications';
const POLLING_INTERVAL = 1000;

class NotificationHandler {
  constructor(notificationBellContainer, notificationContainer) {
    this.notificationBellContainer = notificationBellContainer;
    this.notificationContainer = notificationContainer;
  }

  init() {
    this.notificationBellContainer.click(() => {
      this.notificationBellContainer.children()[0].classList.add('hide');
      this.notificationContainer.toggleClass('hide');
      this.fetchUnreadNotifications();
    })

    this.pollNotifications();
  }

  pollNotifications() {
    setTimeout(() => {
      this.fetchUnsentNotifications();
    }, POLLING_INTERVAL)
  }

  fetchUnsentNotifications() {
    $.get(NOTIFICATION_ENDPOINT + '/unsent')
      .then(data => {
        const { notifications, status } = data;
        if (notifications.length >= 1) {
          this.notificationBellContainer.children()[0].classList.remove('hide');
        }
      });
  }

  fetchUnreadNotifications() {
    $.get(NOTIFICATION_ENDPOINT + '/unread')
      .then(data => {
        const { notifications, status } = data;
        this.notificationContainer.empty();
        notifications.forEach(element => {
          this.notificationContainer.append(`
            <div class="notification">
              <a href="${element.redirect_link}">
                <div class="notification-text">${element.content}</div>
                <div class="notification-text">${this.timeSince(new Date(element.created_at))} ago.</div>
              </a>
            </div>
            <div class="divider"></div>
          `)
        });
      });
  }

  timeSince(date) {
    let seconds = Math.floor((new Date() - date) / 1000);
    let interval = seconds / 31536000;
    if (interval > 1) {
      return Math.floor(interval) + " years";
    }
    interval = seconds / 2592000;
    if (interval > 1) {
      return Math.floor(interval) + " months";
    }
    interval = seconds / 86400;
    if (interval > 1) {
      return Math.floor(interval) + " days";
    }
    interval = seconds / 3600;
    if (interval > 1) {
      return Math.floor(interval) + " hours";
    }
    interval = seconds / 60;
    if (interval > 1) {
      return Math.floor(interval) + " minutes";
    }
    return Math.floor(seconds) + " seconds";
  }
}

let notificationHandler = new NotificationHandler($('*[data-ref="notification-bell-container"]'), $('*[data-ref="notification-container"]'));
notificationHandler.init();
