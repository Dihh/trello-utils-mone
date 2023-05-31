import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    data: Object
  }
  connect() {
    var ctx = document.getElementById(this.element.id);
    var colors = [
      "rgba(255, 99, 132, 0.2)",
      "rgba(153, 102, 255, 0.2)",
      "rgba(54, 162, 235, 0.2)",
      "rgba(255, 206, 86, 0.2)",
      "rgba(0, 255, 221, 0.2)",
      "rgba(229, 0, 255, 0.2)",
      "rgba(50, 255, 0, 0.2)",
      "rgba(75, 192, 192, 1)",
      "rgba(255, 140, 0, 0.7)",
      "rgba(255, 0, 0, 0.5)",
    ];
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
            text: (ctx) => 'Chart.js Line Chart - stacked=' + ctx.chart.options.scales.y.stacked
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
