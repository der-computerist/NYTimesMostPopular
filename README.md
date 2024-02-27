# NYTimesMostPopular
A small UIKit app that fetches articles from New York Times' "Most Popular Articles" API.

API documentation: https://developer.nytimes.com/docs/most-popular-product/1/overview

The following technologies and patterns were used to build the app:
* MVVM (Model-View-ViewModel) Architecture
* Dependency Injection / Dependency Containers
* UIKit
* Reactive Programming with Combine
* XCTest
* iOS 15 and later

## Installation
No special configuration is needed because the app does not rely on third-party libraries.

Just make sure to include an "*API_Key*" key/value pair in the **Info.plist** file, containing the value of the API key.

## Screenshots

| Description | Screenshot |
| --------------- | ------------ |
| Most Viewed Articles | ![1](https://github.com/der-computerist/NYTimesMostPopular/assets/8945123/744040a5-dd23-4bb2-8e2f-8378e56f01ec) |
| Path Options | ![2](https://github.com/der-computerist/NYTimesMostPopular/assets/8945123/5f83f343-e18d-4c29-8311-5775828d40c9) |
| Period Options | ![3](https://github.com/der-computerist/NYTimesMostPopular/assets/8945123/ebe77afb-9e99-4d0a-8593-7a108e47f5ad) |
| Most Emailed Articles | ![4](https://github.com/der-computerist/NYTimesMostPopular/assets/8945123/33268cd0-77d1-42b5-b0ed-4e689dc18490) |
| Most Shared Articles | ![7](https://github.com/der-computerist/NYTimesMostPopular/assets/8945123/2030bb16-feca-435c-a9bd-43629886b46d) |
| Fetching articles... | ![5](https://github.com/der-computerist/NYTimesMostPopular/assets/8945123/ff0a1a79-3230-42c5-a071-5b136f9706e6) |
| Article Details | ![6](https://github.com/der-computerist/NYTimesMostPopular/assets/8945123/f99e8b10-83f2-43bf-9517-4fe46fa8b5b8) |


