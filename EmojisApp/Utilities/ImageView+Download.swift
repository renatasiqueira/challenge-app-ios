import UIKit
import RxSwift
import RxCocoa

func downloadTask(url: URL, placeholder: UIImage = UIImage()) -> Observable<UIImage> {
    guard let request = try?URLRequest(url: url, method: .get) else { return Observable.just(placeholder) }

    return URLSession.shared.rx.response(request: request)
        .map { (response: HTTPURLResponse, data: Data) -> UIImage in
            guard
                response.statusCode == 200,
                let mimeType = response.mimeType, mimeType.hasPrefix("image"),
                let image = UIImage(data: data)
            else { return placeholder }
            return image
        }
}

extension UIImageView {

    func downloadedImage(from url: URL) -> Disposable {
        return downloadTask(url: url)
            .observe(on: MainScheduler.instance)
            .do(onNext: { [weak self] image in
                self?.image = image
            })
                .subscribe()
                }

    //    func downloadedImage(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
    //      //  contentMode = mode
    //        URLSession.shared.dataTask(with: url) { data, response, error in
    //            guard
    //                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
    //                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
    //                let data = data, error == nil,
    //                let image = UIImage(data: data)
    //                else { return }
    //            DispatchQueue.main.async { [weak self] in
    //                self?.contentMode = mode
    //                self?.image = image
    //            }
    //        }.resume()
    //    }

}
