import Artist from 0x01

transaction(){

    prepare(account: AuthAccount){

        let collection <- Artist.createCollection()
        account.save(<- collection, to: /storage/ArtistCollection)
        account.link<&Artist.Collection>(/public/ArtistCollection, target: /storage/ArtistCollection)

    }
}
 