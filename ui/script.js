$(() => {
    const updateHudElements = (data) => {
        let e = data

        if (e.type === 'interface:update'){
            $('#contvida').text(Math.round(e.health) + '%')
            $('#contshield').text(Math.round(e.shield) + '%')
            $('#contfood').text(Math.round(e.hunger) + '%')
            $('#contwater').text(Math.round(e.thirst) + '%')   
            if(e.health === -100) {$('#contvida').text('0' + '%')}
        }
    }

    const setHudToScreen = (data, interface) => {
        let e = data
        if(interface.type === 'whenUse'){
            const health = Math.round(e.health)
            const shield = Math.round(e.shield)
            const hunger = Math.round(e.hunger)
            const thirst = Math.round(e.thirst)

            if(health > data.percent) { $('.vida').hide(300) } else if(health < data.percent) { $('.vida').show(300) }
            if(shield === 0) { $('.shield').hide(300) } else if(shield =~ 0) { $('.shield').show(300) }
            if(hunger > data.percent) { $('.comida').hide(300) } else if(hunger < data.percent) { $('.comida').show(300) }
            if(thirst > data.percent) { $('.bebida').hide(300) } else if(thirst < data.percent) { $('.bebida').show(300) }

            
        } else if(interface.type === 'default'){
            $('.vida').show(0)
            $('.shield').show(0)
            $('.comida').show(0)
            $('.bebida').show(0)
        }
    }

    eventListener = () => {
        self = {}

        self.init = () => {
            window.addEventListener('message', (event) => {
                const e = event.data
                updateHudElements(e)
                setHudToScreen(e, {type : e.method})
            })
        }

        return self
    }

    eventListener = eventListener()

    eventListener.init()
})