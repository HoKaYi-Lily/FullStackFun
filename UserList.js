
function showData() {
    let p = fetch('https://fakerestapi.azurewebsites.net/api/v1/Users')

    p.then(function (response) {
        return response.json()
    }).then(function (d) {
            let tbody = document.querySelector("tbody")
            tbody.innerHTML = ""
            let x = d.length;
            for (let i = 0; i < x; i++) {
                tbody.innerHTML += `<tr>
                                <td> ${d[i].id} </td>
                                <td> ${d[i].userName} </td>
                                <td> ${d[i].password} </td>
                            </tr>`
            }

        })
}
