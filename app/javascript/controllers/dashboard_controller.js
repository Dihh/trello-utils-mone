import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    data: Object
  }
  connect() {
    var ctx = document.getElementById(this.element.id);
    new Chart(ctx, {
      type: 'line',
      data: {
        labels: this.dataValue.labels,
        datasets: this.dataValue.datast
      },
      options: {
        responsive: true,
        scales: {
          y: {
            stacked: true,
            beginAtZero: true
          }
        },
        plugins: {
          title: {
            display: true,
            text: (ctx) => 'Active analysis data'
          },
          tooltip: {
            mode: 'index'
          },
          filler: {
            propagate: false,
          }
        },
        interaction: {
          mode: 'nearest',
          axis: 'x',
          intersect: false
        }
      }
    });
  }
}
