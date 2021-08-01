import Artist from "./contract.cdc"

// Return an array of formatted Pictures that exist in the account with the a specific address.
// Return nil if that account doesn't have a Picture Collection.
pub fun main(address: Address): [String]? {

    let acc = getAccount(address)

    let collectionRef = acc.getCapability<&Artist.Collection>(/public/ArtistCollection).borrow()

    if(collectionRef == nil || collectionRef!.getPixels().length == 0){
        return nil
    }
    return collectionRef!.getPixels()






}