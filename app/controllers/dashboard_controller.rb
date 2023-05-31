class DashboardController < ApplicationController
  def index
    @dashboard = {
      labels: [1,1,2,2],
      datast: [
        {
          label: 'My First dataset',
          data: [3, 3, 3, 3],
          borderColor: "#6bd098",
          backgroundColor: "#6bd098",
          fill: true
        },
        {
          label: 'My Second dataset',
          data: [3, 3, 3, nil],
          borderColor: "#f17e5d",
          backgroundColor: "#f17e5d",
          fill: true
        },
        {
          label: 'My Third dataset',
          data: [3, 3, 3, nil],
          borderColor: "#fcc468",
          backgroundColor: "#fcc468",
          fill: true
        }
      ]
    }
  end
end
