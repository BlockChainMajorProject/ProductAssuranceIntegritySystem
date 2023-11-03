pragma solidity ^0.8.12;

contract product {

    uint256 sellerCount;
    uint256 productCount;

    struct seller{
        uint256 sellerId;
        bytes32 sellerName;
    }
    mapping(uint=>seller) public sellers;

    struct productItem{
        uint256 productId;
        bytes32 productSN;
        bytes32 productName;
        bytes32 productBrand;
        uint256 productPrice;
        bytes32 productStatus;
    }

    mapping(uint256=>productItem) public productItems;
    mapping(bytes32=>uint256) public productMap;
    mapping(bytes32=>bytes32) public productsManufactured;
    mapping(bytes32=>bytes32) public productsForSale;
    mapping(bytes32=>bytes32) public productsSold;
    mapping(bytes32=>bytes32[]) public productsWithSeller;
    mapping(bytes32=>bytes32[]) public productsWithConsumer;
    mapping(bytes32=>bytes32[]) public sellersWithManufacturer;


   



    //PRODUCT SECTION

    function addProduct(bytes32 _manufactuerID, bytes32 _productName, bytes32 _productSN, bytes32 _productBrand,
    uint256 _productPrice) public{
        productItems[productCount] = productItem(productCount, _productSN, _productName, _productBrand,
        _productPrice, "Available");
        productMap[_productSN] = productCount;
        productCount++;
        productsManufactured[_productSN] = _manufactuerID;
    }


   

    //SELL Product

    function manufacturerSellProduct(bytes32 _productSN, bytes32 _sellerCode) public{
        productsWithSeller[_sellerCode].push(_productSN);
        productsForSale[_productSN] = _sellerCode;

    }

    function sellerSellProduct(bytes32 _productSN, bytes32 _consumerCode) public{   
        bytes32 pStatus;
        uint256 i;
        uint256 j=0;

        if(productCount>0) {
            for(i=0;i<productCount;i++) {
                if(productItems[i].productSN == _productSN) {
                    j=i;
                }
            }
        }

        pStatus = productItems[j].productStatus;
        if(pStatus == "Available") {
            productItems[j].productStatus = "NA";
            productsWithConsumer[_consumerCode].push(_productSN);
            productsSold[_productSN] = _consumerCode;
        }


    }

   
  

    //Verify

    function verifyProduct(bytes32 _productSN, bytes32 _consumerCode) public view returns(bool){
        if(productsSold[_productSN] == _consumerCode){
            return true;
        }
        else{
            return false;
        }
    }
}