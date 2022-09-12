class TopicsHandler {
  constructor(container) {
    this.topicsContainer = container;
  }

  init() {
    this.topicsContainer.select2({
      tags: true
    });
  }
}

let topicsHandler = new TopicsHandler($('.topics-list'));
topicsHandler.init();
