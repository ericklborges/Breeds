# Breeds

Este é um aplicativo feito para o estudo de diferentes abordagens de desenvolvimento da camada de `View`. São duas muito comuns, uma que lista raças de cachorros em uma collection, e a outra é uma tela de detalhe que aparece quando você seleciona uma das raças.

## Configurações do projeto

1. Gerar API Key em [thedogapi.com](http://thedogapi.com)
2.  Instalar o Bundler:  `$ sudo gem install bundler`

💎 O Bundler é um gerenciador de gemas (aplicações em ruby), e neste caso estamos instalando ele para usar a ferramenta `cocoapods-keys`, como pode ser visto no arquivo `Gemfile` na raiz do projeto. Esta ferramenta nos ajuda a evitar que nossas chaves privadas subam para o repositório.

3. Clonar o [repositório](https://github.com/ericklborges/Breeds)
4. Instalar Gemas  `$ Bundler install`
5. Instalar dependências do projeto `$ Bundle exec pod install`
6. Quando solicitado,  entrar com API Key solicitada no terminal

## Refatorando Storyboard para View Coding

O passo a passo a seguir detalha a refatoração da camada de de View deste projeto, de Storyboard + Xibs para View Coding usando UIKit.

Você pode dar um checkout para a branch `viewCode/Storyboard`, ou para a tag `live-code-start` para navegar até o momento inicial deste tutorial.

🏷 As tags marcadas ao longo do passo a passo te levam para o ponto do desenvolvimento onde estão. Navegue até a pasta do projeto, e digite o comando `$ git checkout <tag-name>` no terminal para usar uma tag. (e.g. o comando `$ git checkout live-code-start` te leva ao commit inicial do passo a passo a seguir)

## Passo a passo

### Inicialização

<details>
<summary>
1. Trocar main interface para <b>LaunchScreen</b> nos general settings do projeto
</summary> 
<p>
  <img src="Readme Images/Main interface.png">
</p>
</details>

<details>
<summary>
2. Instanciar  <b>UINavigationController</b> passando a <b>BreedCollectionViewController</b> com o root, e setar ela como <b>window?.rootViewController</b> no <b>SceneDelegate</b>
</summary> 
<p>
  
```swift
func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = scene as? UIWindowScene else { return }
    window = UIWindow(windowScene: windowScene)

    let controller = BreedsCollectionViewController()
    let navigation = UINavigationController(rootViewController: controller)

    window?.rootViewController = navigation
    window?.backgroundColor = BackgroundColor.main
    window?.makeKeyAndVisible()
}
```

</p>
</details>

### Refatorando BreedCollectionViewCell

<details>
<summary>
3. Substituir <b>outlets</b> por views criadas programaticamente na <b>BreedCollectionViewCell</b>
</summary> 
<p>
  
```swift
// MARK: Views
let imageView: UIImageView = {
    let image = UIImageView(frame: .zero)
    image.clipsToBounds = true
    image.contentMode = .scaleAspectFill
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
}()

let overlayView: UIView = {
    let view = UIImageView(frame: .zero)
    view.backgroundColor = BackgroundColor.overlay
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
}()

let nameLabel: UILabel = {
    let label = UILabel(frame: .zero)
    label.numberOfLines = 1
    label.textColor = TextColor.primary
    label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
}()
```
</p>
</details>

<details>
<summary>
4. Criar <b>extension</b> adicionando <b>views</b> e configurando <b>constraints</b>
</summary> 
<p>
  
```swift
// MARK: Autolayout
extension BreedCollectionViewCell {
    func setupViewHierarchy() {
        addSubview(imageView)
        addSubview(overlayView)
        overlayView.addSubview(nameLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),

            overlayView.heightAnchor.constraint(equalToConstant: 24),
            overlayView.bottomAnchor.constraint(equalTo: bottomAnchor),
            overlayView.leadingAnchor.constraint(equalTo: leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: trailingAnchor),

            nameLabel.topAnchor.constraint(equalTo: overlayView.topAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: overlayView.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: overlayView.leadingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: overlayView.trailingAnchor, constant: -16)
        ])
    }
}
```

</p>
</details>

<details>
<summary>
5. Criar <b>init</b> chamando os métodos na ordem correta  
</summary> 
<p>
  
```swift
// MARK: Life Cycle
override init(frame: CGRect) {
    super.init(frame: .zero)
    setupViewHierarchy()
    setupConstraints()
}

@available(*, unavailable)
required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
}
```

</p>
</details>

<details>
<summary>
6. Criar protocolo <b>ViewCodable</b>, e atualiza init com método <b>setupViews()</b>
</summary> 
<p>
  
```swift
protocol ViewCodable {
    func setupViews()
    func setupViewHierarchy()
    func setupConstraints()
    func setupAditionalConfiguration()
}

extension ViewCodable {
    func setupViews() {
        setupViewHierarchy()
        setupConstraints()
        setupAditionalConfiguration()
    }

    func setupAditionalConfiguration() { }
}

// MARK: Life Cycle
override init(frame: CGRect = .zero) {
    super.init(frame: frame)
    setupViews()
}
```

</p>
</details>
    
### Testando BreedCollectionViewCell

</p>
</details>

<details>
<summary>
7. Escrever teste para visualizar interface da classe <b>BreedCollectionViewCellSpec</b>
</summary> 
<p>
  
```swift
import Quick
import Nimble
import Nimble_Snapshots

@testable import Breeds

class BreedCollectionViewCellSpec: QuickSpec {
    override func spec() {
        describe("BreedCollectionViewCell") {
            var sut: BreedCollectionViewCell!
            
            context("when initialized") {
                beforeEach {
                    sut = BreedCollectionViewCell()
                    sut.setup(image: .stub(url: AssetHelper.LocalImage.carameloDog.url))
                    sut.frame.size = CGSize(width: 200, height: 200)
                }
                
                it("should layout itself properly") {
//                    expect(sut).toEventually(haveValidSnapshot(named: "BreedCollectionViewCell_Layout"), timeout: 0.5)
                    expect(sut).toEventually(recordSnapshot(named: "BreedCollectionViewCell_Layout", identifier: nil, usesDrawRect: false), timeout: 0.5)
                }
            }
        }
    }
}
```

</p>
</details>

<details>
<summary>
8. Referência da pasta <b>ReferenceImages</b> no <b>target</b> de <b>BreedsTests</b> (opcional)
</summary> 
<p>
  
Atenção às configurações Copy items if needed, e Create folder references

<img src="Readme Images/Reference Images.png">
</p>
</details>

🏷️`live-code-goal`

### Refatorando BreedsCollectionViewController

<details>
<summary>
9. Atualizar o método <b>setupNavigation()</b> da <b>BreedsCollectionViewController</b> setando o title
</summary> 
<p>

```swift
func setupNavigation() {
    title = "Breeds"
    navigationController?.applyCustomAppearence()
    navigationController?.navigationBar.prefersLargeTitles = true
}
```

</p>
</details>

<details>
<summary>
10. Criar <b>FlowLayout</b> e <b>Collection</b> programaticamente
</summary> 
<p>

```swift
// MARK: Views
let collectionFlowLayout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.minimumLineSpacing = .zero
    layout.minimumInteritemSpacing = .zero
    return layout
}()

lazy var collectionView: UICollectionView = {
    let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionFlowLayout)
    collection.delegate = self
    collection.dataSource = self
    collection.prefetchDataSource = self
    collection.backgroundColor = BackgroundColor.main
    collection.register(BreedCollectionViewCell.self, forCellWithReuseIdentifier: Identifier.Cell.breedCell)
    collection.translatesAutoresizingMaskIntoConstraints = false
    return collection
}()
```

</p>
</details>

<details>
<summary>
11. Criar <b>extension</b> implementando o protocolo <b>ViewCodable</b>
</summary> 
<p>

```swift
// MARK: Autolayout
extension BreedsCollectionViewController: ViewCodable {
    func setupViewHierarchy() {
        view.addSubview(collectionView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
```
    
</p>
</details>

<details>
<summary>
12. Chamar <b>setupViews()</b> no <b>viewDidLoad()</b>
</summary> 
<p>

```swift
// MARK: Life Cycle
override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupNavigation()
    viewModel.fetchImages()
}
```

</p>
</details>

🏷️`live-code-extra-collection`

### Refatorando BreedDetailView

<details>
<summary>
13. Criar classe para componente <b>BreedDetailLabel</b>
</summary> 
<p>

```swift
class BreedDetailLabel: UILabel {

    // MARK: Init
    init() {
        super.init(frame: .zero)
        self.numberOfLines = 0
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Setup
    func setup(title: String, description: String?) {
        guard let description = description, !description.isEmpty else {
            removeFromSuperview()
            return
        }

        let attributedText = NSMutableAttributedString()
        attributedText.bold(title)
        attributedText.regular(description)
        self.attributedText = attributedText
    }
}
```

</p>
</details>

<details>
<summary>
14. Substituir <b>outlets</b> por views criadas programaticamente na <b>BreedDetailView</b>, adicionando <b>scrollView</b> e <b>stackView</b>
</summary> 
<p>

```swift
// MARK: Views
let scrollView: UIScrollView = {
    let scrollView = UIScrollView(frame: .zero)
    scrollView.showsHorizontalScrollIndicator = false
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    return scrollView
}()

let breedImage: UIImageView = {
    let image = UIImageView(frame: .zero)
    image.clipsToBounds = true
    image.contentMode = .scaleAspectFill
    image.translatesAutoresizingMaskIntoConstraints = false
    return image
}()

let stackView: UIStackView = {
    let stack = UIStackView(frame: .zero)
    stack.spacing = 16.0
    stack.axis = .vertical
    stack.alignment = .fill
    stack.distribution = .fill
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
}()

let nameLabel = BreedDetailLabel()
let weightLabel = BreedDetailLabel()
let heightLabel = BreedDetailLabel()
let lifespanLabel = BreedDetailLabel()
let temperamentLabel = BreedDetailLabel()
let bredForLabel = BreedDetailLabel()
let breedGroupLabel = BreedDetailLabel()
let originLabel = BreedDetailLabel()
```

</p>
</details>

<details>
<summary>
15. Criar <b>extension</b> implementando o protocolo <b>ViewCodable</b>
</summary> 
<p>

```swift
// MARK: Autolayout
extension BreedDetailView: ViewCodable {
    func setupViewHierarchy() {
        addSubview(scrollView)

        scrollView.addSubview(breedImage)
        scrollView.addSubview(stackView)

        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(weightLabel)
        stackView.addArrangedSubview(heightLabel)
        stackView.addArrangedSubview(lifespanLabel)
        stackView.addArrangedSubview(temperamentLabel)
        stackView.addArrangedSubview(bredForLabel)
        stackView.addArrangedSubview(breedGroupLabel)
        stackView.addArrangedSubview(originLabel)
        stackView.addArrangedSubview(nameLabel)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),

            breedImage.topAnchor.constraint(equalTo: scrollView.topAnchor),
            breedImage.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            breedImage.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            breedImage.widthAnchor.constraint(equalTo: widthAnchor),
            breedImage.heightAnchor.constraint(equalTo: breedImage.widthAnchor, multiplier: 1),

            stackView.topAnchor.constraint(equalTo: breedImage.bottomAnchor, constant: 16),
            stackView.bottomAnchor.constraint(greaterThanOrEqualTo: scrollView.bottomAnchor, constant: -16),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16)
        ])
    }

    func setupAditionalConfiguration() {
        backgroundColor = BackgroundColor.main
    }
}
```

</p>
</details>

<details>
<summary>
16. Criar Init para a <b>BreedDetailView</b>
</summary> 
<p>

```swift
init() {
    super.init(frame: .zero)
    setupViews()
}

@available(*, unavailable)
required init?(coder: NSCoder) {
    super.init(coder: coder)
}
```

</p>
</details>

<details>
<summary>
17. Atualizar <b>setup</b> com método do componente <b>BreedDetailLabel</b> e remover setup da <b>BreedDetailView</b>
</summary> 
<p>

```swift
func setup(breed: Breed?, imageUrl: String?) {
    guard
        let breed = breed,
        let imageUrl = imageUrl
        else { return }

    breedImage.setImage(url: URL(string: imageUrl))
    nameLabel.setup(title: "Name: ", description: breed.name)
    weightLabel.setup(title: "Weight: ", description: breed.weight.metric)
    heightLabel.setup(title: "Height: ", description: breed.height.metric)
    lifespanLabel.setup(title: "Life Span: ", description: breed.lifeSpan)
    temperamentLabel.setup(title: "Temperament: ", description: breed.temperament)
    bredForLabel.setup(title: "Breed For: ", description: breed.bredFor)
    breedGroupLabel.setup(title: "BreedGroup: ", description: breed.breedGroup)
    originLabel.setup(title: "Origin: ", description: breed.origin)
}

// func setup(title: String, description: String?, label: UILabel) {
//    guard let description = description, !description.isEmpty else {
//        label.removeFromSuperview()
//        return
//    }
//    
//    let attributedText = NSMutableAttributedString()
//    attributedText.bold(title)
//    attributedText.regular(description)
//    label.attributedText = attributedText
// }
```

</p>
</details>

### Testando BreedDetailView

<details>
<summary>
18. Escrever teste para visualizar interface da classe <b>BreedDetailView</b>
</summary> 
<p>

```swift
import Quick
import Nimble
import Nimble_Snapshots

@testable import Breeds

class BreedDetailViewSpec: QuickSpec {
    override func spec() {
        describe("BreedCollectionView") {
            var sut: BreedDetailView!

            context("when initialized") {
                beforeEach {
                    sut = BreedDetailView()
                    sut.setup(breed: .stub(), imageUrl: AssetHelper.LocalImage.carameloDog.url)
                    sut.frame.size = CGSize(width: 375, height: 600)
                }

                it("should layout itself properly") {
//                    expect(sut).toEventually(recordSnapshot(named: "BreedDetailView_Layout", identifier: nil, usesDrawRect: false), timeout: 0.5)
                    expect(sut).toEventually(haveValidSnapshot(named: "BreedDetailView_Layout"), timeout: 1)
                }
            }
        }
    }
}
```

</p>
</details>

### Refatorando BreedDetailViewController

<details>
<summary>
19. Substituir <b>outlet</b> da <b>baseView</b> na <b>BreedDetailViewController</b>
</summary> 
<p>

```swift
// MARK: Views
let baseView = BreedDetailView()
```

</p>
</details>

<details>
<summary>
20. Adaptar init da <b>BreedDetailViewController</b>, removendo o <b>coder</b>
</summary> 
<p>

```swift
// MARK: Init
init(breed: Breed, imageUrl: String) {
    self.breed = breed
    self.imageUrl = imageUrl
    super.init(nibName: nil, bundle: nil)
}

@available(*, unavailable)
required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
}
```

</p>
</details>

<details>
<summary>
21. Atribuir <b>baseView</b> à <b>view</b> no <b>override</b> do método <b>loadView()</b>
</summary> 
<p>

```swift
// MARK: Life Cycle
override func loadView() {
    view = baseView
}
```

</p>
</details>

<details>
<summary>
22. Atualizar <b>setup()</b> da <b>BreedDetailViewController</b> com configuração do <b>navigationItem</b>
</summary> 
<p>

```swift
// MARK: Setup
private func setup() {
    title = breed.name
    navigationItem.largeTitleDisplayMode = .never
    baseView.setup(breed: breed, imageUrl: imageUrl)
}
```

</p>
</details>

### Adaptando BreedsCollectionViewController

<details>
<summary>
23. Substituir <b>storyboard</b> por instância direta da classe <b>BreedDetailViewController</b> no método <b>showDetailForSelectedBreed()</b>
</summary> 
<p>

```swift
func showDetailForSelectedBreed() {
    guard
        let selectedBreed = viewModel.currentSelectedBreed,
        let selectedImageUrl = viewModel.currentSelectedImage?.url
        else { return }

    let breedDetailController = BreedDetailViewController(breed: selectedBreed, imageUrl: selectedImageUrl)
    show(breedDetailController, sender: self)
}
```

</p>
</details>

🏷️`live-code-extra-detail`
