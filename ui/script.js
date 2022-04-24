$(() => {
    window.addEventListener('message', (event) => {
        const e = event.data
        if (e.type === 'interface:update'){
            $('#contvida').text(Math.round(e.health) + '%')
            $('#contshield').text(Math.round(e.shield) + '%')
            $('#contfood').text(Math.round(e.hunger) + '%')
            $('#contwater').text(Math.round(e.thirst) + '%')
        }
    })
})