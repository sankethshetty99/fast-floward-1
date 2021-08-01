import Artist from "./contract.cdc"

// Create a Picture Collection for the transaction authorizer.
transaction {

    prepare(account: AuthAccount){

        let collection <- Artist.createCollection()
        account.save(<- collection, to: /storage/ArtistCollection)
        account.link<&Artist.Collection>(/public/ArtistCollection, target: /storage/ArtistCollection)

    }

}