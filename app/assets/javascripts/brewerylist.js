const BREWERIES = {}

BREWERIES.show = () => {
  const table = $("#brewerytable")

  BREWERIES.list.forEach((brewery) => {
    table.append('<tr>'
      + '<td>' + brewery['name'] + '</td>'
      + '<td>' + brewery['year'] + '</td>'
      + '<td>' + brewery['beers']['count'] + '</td>'
      + '<td>' + brewery['active'] + '</td>'
      + '</tr>')
  })
}

document.addEventListener("turbolinks:load", () => {
    $.getJSON('breweries.json', (breweries) => {
      BREWERIES.list = breweries
      BREWERIES.show()
    })
  })
