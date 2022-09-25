import consumer from "channels/consumer"

if (window.location.pathname === '/') {
  consumer.subscriptions.create("QuestionChannel", {
    connected() {
      console.log('Subscribed to QuestionChannel...')
    },
  
    disconnected() {
    },
  
    received(data) {
      notificationPopHandler.init();
    }
  });
}
