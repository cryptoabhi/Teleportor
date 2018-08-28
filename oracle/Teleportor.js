module.exports = (params) => {
    const { Teleportor, onData } = params;

    Teleportor.methods.closed().call()
    .then(result => {
        if (result === true){
            console.log("(EE) Teleportor closed ... exiting");
            process.exit(0);
        }
    })

    Teleportor.events.Teleport({
//        fromBlock: 0
    })
        .on('data', event => {
            if (onData) {
                onData(event);
            }
            else
                console.log("(II) Teleportor event " + event.returnValues);
        })
        .on('changed', reason => console.log("(WW) TeleportOracle: " + reason))
        .on('error', reason => console.log("(EE) TeleportOracle: " + reason));

        Teleportor.events.Closed({
    })
        .on('data', () => {
            console.log("(END) Teleportor closed ... exiting");
            process.exit(0);
        })
        .on('changed', reason => console.log("(WW) TeleportOracle: " + reason))
        .on('error', reason => console.log("(EE) TeleportOracle: " + reason));
}
