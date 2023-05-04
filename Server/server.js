const app = require("./app")
const config = require("./app/config")

const MongoDB = require("./app/utils/mongodb.util")
async function startSever(){
    try {
        await MongoDB.connect(config.db.uri);
        console.log("Da ket noi toi CSDL");
        const PORT = config.app.port;
        app.listen(PORT,()=>{
            console.log(`Server dang chay tren cong ${PORT}`);
        })
    } catch (error) {
        console.log("Ket noi bi loi",error);
        process.exit()
    }
}
startSever()
