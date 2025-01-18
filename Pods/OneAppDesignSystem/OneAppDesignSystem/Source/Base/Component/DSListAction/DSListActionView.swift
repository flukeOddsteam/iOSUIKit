import Foundation
import UIKit

/// Enum type of cell list action.
public enum ListActionViewStyle {
    case listActionIcons(viewModels: [ListActionIconViewModel])
    case listActionIconSpot(viewModels: [ListActionIconSpotViewModel])
    case listActionIconValue(viewModels: [DSListActionIconValueViewModel])
    case listAccountWithIcon(viewModels: [DSBottomSheetDropdownViewModel.DSBottomSheetItem])
    case listActionToggle(viewModels: [ListActionToggleViewModel])
    case listActionMenu(viewModels: [ListActionMenuViewModel])
    case listActionAvatarFavorite(viewModels: [DSListActionAvatarFavoriteViewModel])
    case listActionAvatarGhost(viewModels: [DSListActionAvatarGhostViewModel])
}

public enum DSListActionViewStyleAccessibilityIdentifier {
    case listActionIcons(prefixListActionIconsId: String, prefixTitleLabelId: String)
    case listActionIconSpot(prefixListActionIconSpotId: String, prefixTitleLabelId: String)
    case listAccountWithIcon(prefixListAccountWithIconid: String,
                             prefixTitleLabelId: String,
                             prefixFirstLabelId: String,
                             prefixSecondLabelId: String)
    case listActionToggle(prefixListActionToggleId: String,
                          prefixTitleLabelId: String,
                          prefixToggleId: String,
                          prefixDescriptionLabelId: String,
                          prefixCircleViewId: String)
    case listActionMenu(prefixListActionMenuId: String,
                        prefixTitleLabelId: String,
                        prefixValueLabelId: String,
                        prefixDescriptionLabelId: String)
    case listActionAvatarFavorite(prefixListActionAvatarFavoriteId: String,
                                  prefixTitleLabelId: String,
                                  prefixFavoriteButtonId: String)
    case listActionAvatarGhost(prefixListActionAvatarGhostId: String,
                               prefixTitleLabelId: String,
                               prefixPrimaryButtonId: String,
                               prefixSecondaryButtonId: String)
    case listActionIconValue(prefixListActionIconValueId: String,
                             prefixTitleLabelId: String,
                             prefixFirstLabelId: String,
                             prefixSecondLabelId: String)
}

/// ListActionDelegate for get action from listActionTableView.
public protocol ListActionViewDelegate: AnyObject {
    /// Did select row of table view.
    /// - Parameter view: view of listAction
    /// - Parameter index: row of table view.
    func listActionView(_ view: DSListActionView, didSelectRowAt index: Int)
    func listActionView(_ view: DSListActionView, didScroll offset: CGPoint)
}

public extension ListActionViewDelegate {
    func listActionView(_ view: DSListActionView, didSelectRowAt index: Int) { }
    func listActionView(_ view: DSListActionView, didScroll offset: CGPoint) { }
}

/// ListActionDelegate for get action from listActionToggleTableView.
public protocol ListActionToggleViewDelegate: AnyObject {
    /// Did select row of table view.
    /// - Parameter index: row of table view.
    /// - Parameter state: state of DSToggle
    func listActionToggleView(index: Int, withState: DSToggleState)
}

/// ListActionDelegate to get Favorite selection on ListActionAvatarFavoriteView
public protocol DSListActionAvatarFavoriteDelegate: AnyObject {
    func listActionAvatarFavoriteView(_ view: DSListActionView,
                                      didSelectFavoriteAt index: Int,
                                      style: DSClickableIconFavoriteStyle)
}

/// ListActionDelegate to get ghost button selection on ListActionAvatarGhostView
public protocol DSListActionAvatarGhostDelegate: AnyObject {
    func listActionAvatarTableViewCell(_ view: DSListActionView,
                                       didSelectPrimaryButtonAt index: Int)
    
    func listActionAvatarTableViewCell(_ view: DSListActionView,
                                       didSelectSecondaryButtonAt index: Int)
}

/**
 Custom component DSListActionView
 
 ![image](/DocumentationImages/ds-list-action.png)

 **Usage Example:**
 1. Create UIView on .xib file and assign `DSListActionTableView` Class to the UIVIew
 2. Binding constraint and don't set `Height`
 3. Connect UIView to `@IBOutlet` in text editor
 4. Call `func setup()` in `viewDidLoad()`
  ```
    @IBOutlet weak var tableView: DSListActionTableView!
 
     // Example: Create a ViewModel that contains the required data for DSListActionView - listActionIcons type
     var iconviewModels: [ListActionIconViewModel] = [
         ListActionIconViewModel(
             text: "Label",
             leftIcon: DSIcons.icon24OutlinePlaceholder,
             rightIcon: DSIcons.icon24OutlinePlaceholder
         ),
         ListActionIconViewModel(text: "Label (Max 2 lines) Label (Max 2 lines)Label (Max 2 lines)")
     ]
 
     // Example: Create a ViewModel that contains the required data for DSListActionView - listActionToggle type
 
        // labelSize: large
         var toggleViewModels: [ListActionToggleViewModel] = [
             ListActionToggleViewModel(
                 text: "Label",
                 leftIcon: DSIcons.icon24OutlinePlaceholder,
                 state: DSToggleState.onActive,
                 description: "Description",
                 labelSize: DSListActionToggleLabelSize.large
             ),
             ListActionToggleViewModel(
                 text: "Label",
                 leftIcon: DSIcons.icon24OutlinePlaceholder,
                 state: DSToggleState.offActive,
                 description: "Description",
                 labelSize: DSListActionToggleLabelSize.large
             )
         ]
     
         // labelSize: small
          var toggleViewModels: [ListActionToggleViewModel] = [
              ListActionToggleViewModel(
                  text: "Label",
                  leftIcon: DSIcons.icon24OutlinePlaceholder,
                  state: DSToggleState.onActive,
                  description: "Description",
                  labelSize: DSListActionToggleLabelSize.small
              ),
              ListActionToggleViewModel(
                  text: "Label",
                  leftIcon: DSIcons.icon24OutlinePlaceholder,
                  state: DSToggleState.offActive,
                  description: "Description",
                  labelSize: DSListActionToggleLabelSize.small
              )
          ]
 
     // Example: Create a ViewModel that contains the required data for DSListActionView - listActionMenu type
     var menuViewModels: [ListActionMenuViewModel] = [
         ListActionMenuViewModel(label: "Label"),
         ListActionMenuViewModel(label: "Label", value: "Value"),
         ListActionMenuViewModel(label: "Label", value: "Value", labelDesc: "description"),
         ListActionMenuViewModel(label: "Label",
                                 value: "Value",
                                 labelDesc: "description",
                                 leftIcon: .url(URL(string: url))),
         ListActionMenuViewModel(label: "Label",
                                 value: "Value",
                                 labelDesc: "description",
                                 leftIcon: .icon(DSIcons.icon24OutlinePlaceholder),
                                 pill: pill1)
     ]
 
    // Example: Create a ViewModel that contains the required data for DSListActionView - listActionAvatarFavorite type
     var avatarFavoriteViewModels: [DSListActionAvatarFavoriteViewModel] = [
         DSListActionAvatarFavoriteViewModel(avatarImage: nil,
                                             label: "Label",
                                             isFavorite: true),
         DSListActionAvatarFavoriteViewModel(avatarImage: nil,
                                             label: "Label")
     ]
    // Example: Create a ViewModel that contains the required data for DSListActionView - listActionAvatarGhost type
     var avatarGhostViewModels : [DSListActionAvatarGhostViewModel] = [
         DSListActionAvatarGhostViewModel(avatarImage: nil,
                                          label: "Label",
                                          primaryButtonImage: SvgIcons.icon24OutlineEdit.image,
                                          secondaryButtonImage: nil),
         DSListActionAvatarGhostViewModel(avatarImage: nil,
                                          label: "Label",
                                          primaryButtonImage: SvgIcons.icon24OutlineEdit.image,
                                          secondaryButtonImage: SvgIcons.icon24OutlineTrash.image)
     ]
     // Example: Create a ViewModel that contains the required data for DSListActionView - listActionIconValue type
     var actionIconValueViewModels: [DSListActionIconValueViewModel] = [
         DSListActionIconValueViewModel(
             text: "Label",
             valueText: "Value",
             secondaryText: "Description",
             leftIcon: DSIcons.icon24OutlinePlaceholder,
             rightIcon: DSIcons.icon24OutlinePlaceholder
         ),
         DSListActionIconValueViewModel(
             text: "Label",
             valueText: "Value",
             secondaryText: "Description",
             leftIcon: DSIcons.icon24OutlinePlaceholder,
             rightIcon: DSIcons.icon24OutlinePlaceholder
         )
     ]
 
      override func viewDidLoad() {
         super.viewDidLoad()
         listActionView.delegate = self
 
         // Example: Setup DSListActionView - listActionIcons type
         listActionView.setup(style: .listActionIcons(viewModels: iconviewModels))
 
         // Example: Setup DSListActionView - listActionToggle type
         listActionView.setup(style: .listActionToggle(viewModels: toggleViewModels))
         listActionView.toggleDelegate = self
         
         // Example: Setup DSListActionView - listActionMenu type
         listActionView.setup(style: .listActionMenu(viewModels: menuViewModels))
 
         // Example: Setup DSListActionView - listActionAvatarFavorite type
         listActionView.setup(style: .listActionMenu(viewModels: avatarFavoriteViewModels))
         listActionView.favoriteDelegate = self
 
         // Example: Setup DSListActionView - listActionAvatarGhost type
         listActionView.setup(style: .listActionMenu(viewModels: avatarGhostViewModels))
         listActionView.ghostDelegate = self
 
         // Example: Setup DSListActionView - listActionIconValue type
         listActionView.setup(style: .listActionIconValue(viewModels: actionIconValueViewModels))
 
         listActionView.tableView.isScrollEnabled = false
      }
  ```
 
 **DSListActionView has 7 styles:**
 - listActionIcons
 - listActionIconSpot
 - listAccountWithIcon
 - listActionToggle
 - listActionMenu
 - listActionAvatarFavorite
 - listActionAvatarGhost
 - listActionIconValue
 
 **listActionIcons, listActionIconSpot and listActionIconValue has 2 styles of title:**
 - h3 (bold)
 - paragraphMedium (regular)
 */
public final class DSListActionView: UIView {
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: IntrinsicTableView!
    
    // MARK: - Private variable
    private var style: ListActionViewStyle?
    
    // Variable to set accessibility identifier
    private var prefixListActionId: String = ""
    private var prefixListActionIconSpotId: String = ""
    private var prefixTitleLabelId: String = ""
    private var prefixFirstLabelId: String = ""
    private var prefixSecondLabelId: String = ""
    private var prefixDescriptionLabelId: String = ""
    private var prefixToggleId: String = ""
    private var prefixValueLabelId: String = ""
    private var prefixListActionAvatarFavoriteId: String = ""
    private var prefixFavoriteButtonId: String = ""
    private var prefixListActionAvatarGhostId: String = ""
    private var prefixPrimaryButtonId: String = ""
    private var prefixSecondaryButtonId: String = ""
    private var prefixListActionIconValueId: String = ""
    private var prefixCircleViewId: String = ""

    // MARK: - Public variable
    /// For use list action delegate.
    public weak var delegate: ListActionViewDelegate?
    
    /// For use list toggle action delegate.
    public weak var toggleDelegate: ListActionToggleViewDelegate?
    
    /// For use list avatar favorite deleage.
    public weak var avatarFavoriteDelegate: DSListActionAvatarFavoriteDelegate?
    
    /// For use list avater ghost delegate.
    public weak var avaterGhostDelegate: DSListActionAvatarGhostDelegate?
        
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupXib()
        setupTableView()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupXib()
        setupTableView()
    }
    
    /// Setup table view.
    /// - Parameter style: type of style to display.
    public func setup(style: ListActionViewStyle, contentInsets: UIEdgeInsets = .zero) {
        tableView.contentInset = contentInsets
        
        updateData(style: style)
    }
    
    /// Update and reload tableview data
    public func updateData(style: ListActionViewStyle) {
        self.style = style
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            self?.tableView.layoutIfNeeded()
        }
    }

    /// Set custom table footer view height
    public func setCustomTableFooterHeight(_ height: CGFloat) {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: height))
        self.tableView.tableFooterView = footerView
    }
    
    public func setScrollEnabled(isScrollEnabled: Bool) {
        tableView.isScrollEnabled = isScrollEnabled
    }
    
    public func setAccessibilityIdentifier(id: String? = nil,
                                           style: DSListActionViewStyleAccessibilityIdentifier) {
        self.accessibilityIdentifier = id
        switch style {
        case .listActionIcons(let prefixListActionIconsId, let prefixTitleLabelId):
            self.prefixListActionId = prefixListActionIconsId
            self.prefixTitleLabelId = prefixTitleLabelId
        case .listActionIconSpot(let prefixListActionIconSpotId, let prefixTitleLabelId):
            self.prefixListActionIconSpotId = prefixListActionIconSpotId
            self.prefixTitleLabelId = prefixTitleLabelId
        case .listActionIconValue(let prefixListActionIconValueId,
                                  let prefixTitleLabelId,
                                  let prefixFirstLabelId,
                                  let prefixSecondLabelId):
            self.prefixListActionIconValueId = prefixListActionIconValueId
            self.prefixTitleLabelId = prefixTitleLabelId
            self.prefixFirstLabelId = prefixFirstLabelId
            self.prefixSecondLabelId = prefixSecondLabelId
        case .listAccountWithIcon(let prefixListAccountWithIconid,
                                  let prefixTitleLabelId,
                                  let prefixFirstLabelId,
                                  let prefixSecondLabelId):
            self.prefixListActionId = prefixListAccountWithIconid
            self.prefixTitleLabelId = prefixTitleLabelId
            self.prefixFirstLabelId = prefixFirstLabelId
            self.prefixSecondLabelId = prefixSecondLabelId
        case .listActionToggle(let prefixListActionToggleId,
                               let prefixTitleLabelId,
                               let prefixToggleId,
                               let prefixDescriptionLabelId,
                               let prefixCircleViewId):
            self.prefixListActionId = prefixListActionToggleId
            self.prefixTitleLabelId = prefixTitleLabelId
            self.prefixToggleId = prefixToggleId
            self.prefixDescriptionLabelId = prefixDescriptionLabelId
            self.prefixCircleViewId = prefixCircleViewId
        case .listActionMenu(let prefixListActionMenuId,
                             let prefixTitleLabelId,
                             let prefixValueLabelId,
                             let prefixDescriptionLabelId):
            self.prefixListActionId = prefixListActionMenuId
            self.prefixTitleLabelId = prefixTitleLabelId
            self.prefixDescriptionLabelId = prefixDescriptionLabelId
            self.prefixValueLabelId = prefixValueLabelId
        case .listActionAvatarFavorite(let prefixListActionAvatarFavoriteId,
                                       let prefixTitleLabelId,
                                       let prefixFavoriteButtonId):
            self.prefixListActionAvatarFavoriteId = prefixListActionAvatarFavoriteId
            self.prefixTitleLabelId = prefixTitleLabelId
            self.prefixFavoriteButtonId = prefixFavoriteButtonId
        case .listActionAvatarGhost(let prefixListActionAvatarGhostId,
                                    let prefixTitleLabelId,
                                    let prefixPrimaryButtonId,
                                    let prefixSecondaryButtonId):
            self.prefixListActionAvatarGhostId = prefixListActionAvatarGhostId
            self.prefixTitleLabelId = prefixTitleLabelId
            self.prefixPrimaryButtonId = prefixPrimaryButtonId
            self.prefixSecondaryButtonId = prefixSecondaryButtonId
        }
    }
}

// MARK: - UITableViewDataSource
extension DSListActionView: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch style {
        case .listActionIcons(let viewModels):
            return viewModels.count
        case .listActionIconSpot(let viewModels):
            return viewModels.count
        case .listActionIconValue(let viewModels):
            return viewModels.count
        case .listActionToggle(let viewModels):
            return viewModels.count
        case .listActionMenu(let viewModels):
            return viewModels.count
        case .listActionAvatarFavorite(let viewModels):
            return viewModels.count
        case .listActionAvatarGhost(let viewModels):
            return viewModels.count
        default:
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = String(indexPath.row)
        
        switch style {
        case .listActionIcons(let viewModels):
            let viewModel = viewModels[indexPath.row]
            let isShowBottomLine = indexPath.row != viewModels.count - 1
            let cell: DSListActionIconTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = DSColor.componentLightBackgroundOnPress
            cell.selectedBackgroundView = backgroundView
            
            cell.configure(viewModel: viewModel, isShowBottomLine: isShowBottomLine)

            // Set accessibility identifier for each DSListActionIcons
            if self.prefixListActionId.isNotEmpty {
                cell.setAccessibilityIdentifier(id: self.prefixListActionId.idConcatenation(row),
                                                titleLableId: self.prefixTitleLabelId.idConcatenation(row))
            }
            
            return cell
        case .listActionIconSpot(let viewModels):
            let viewModel = viewModels[indexPath.row]
            let isShowBottomLine = indexPath.row != viewModels.count - 1
            let cell: DSListActionIconSpotTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            let backgroundView = UIView()
            backgroundView.backgroundColor = DSColor.componentLightBackgroundOnPress
            cell.selectedBackgroundView = backgroundView
            cell.configure(viewModel: viewModel, isShowBottomLine: isShowBottomLine)
            
            if self.prefixListActionIconSpotId.isNotEmpty {
                cell.setAccessibilityIdentifier(
                    id: self.prefixListActionIconSpotId.idConcatenation(row),
                    titleLableId: self.prefixTitleLabelId.idConcatenation(row)
                )
            }
            
            return cell
        case .listActionToggle(let viewModels):
            let viewModel = viewModels[indexPath.row]
            let isShowBottomLine = indexPath.row != viewModels.count - 1
            let cell: DSListActionToggleTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            
            let backgroundView = UIView()
            backgroundView.backgroundColor = DSColor.componentLightBackgroundOnPress
            cell.selectedBackgroundView = backgroundView
            
            cell.configure(viewModel: viewModel, isShowBottomLine: isShowBottomLine)
            cell.toggle.tagId = indexPath.row
            cell.toggle.delegate = self
            cell.selectionStyle = .none
            
            // Set accessibility identifier for each DSListActionToggle
            if self.prefixListActionId.isNotEmpty {
                cell.setAccessibilityIdentifier(id: self.prefixListActionId.idConcatenation(row),
                                                titleLabelId: self.prefixTitleLabelId.idConcatenation(row),
                                                toggleId: self.prefixToggleId.idConcatenation(row),
                                                descriptionLabelId: self.prefixDescriptionLabelId.idConcatenation(row),
                                                circleViewId: self.prefixCircleViewId.idConcatenation(row)
                )
            }
            
            return cell
        case .listActionMenu(let viewModels):
            let viewModel = viewModels[indexPath.row]
            let isShowBottomLine = indexPath.row != viewModels.count - 1
            let cell: DSListActionMenuTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            
            cell.configure(viewModel: viewModel, isShowBottomLine: isShowBottomLine)
            
            // Set accessibility identifier for each DSListActionMenu
            if self.prefixListActionId.isNotEmpty {
                cell.setAccessibilityIdentifier(id: self.prefixListActionId.idConcatenation(row),
                                                titleLabelId: self.prefixTitleLabelId.idConcatenation(row),
                                                valueLabelId: self.prefixValueLabelId.idConcatenation(row),
                                                descriptionLabelId: self.prefixDescriptionLabelId.idConcatenation(row))
            }
            
            return cell
        case .listActionAvatarFavorite(let viewModels):
            let viewModel = viewModels[indexPath.row]
            let isShowBottomLine = indexPath.row != viewModels.count - 1
            let cell: DSListActionAvatarTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            
            cell.configure(viewModel: viewModel, isShowBottomLine: isShowBottomLine)
            cell.tag = indexPath.row
            cell.delegate = self
            
            // Set accessibility identifier for each DSListActionAvatarFavorite
            if self.prefixListActionAvatarFavoriteId.isNotEmpty {
                cell.setAccessibilityIdentifier(id: self.prefixListActionAvatarFavoriteId.idConcatenation(row),
                                                titleLableId: self.prefixTitleLabelId.idConcatenation(row),
                                                favoriteButtonId: self.prefixFavoriteButtonId.idConcatenation(row))
            }
            
            return cell
        case .listActionAvatarGhost(let viewModels):
            let viewModel = viewModels[indexPath.row]
            let isShowBottomLine = indexPath.row != viewModels.count - 1
            let cell: DSListActionAvatarTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            
            cell.configure(viewModel: viewModel, isShowBottomLine: isShowBottomLine)
            cell.tag = indexPath.row
            cell.delegate = self
            
            // Set accessibility identifier for each DSListActionAvatarGhost
            if self.prefixListActionAvatarGhostId.isNotEmpty {
                cell.setAccessibilityIdentifier(id: self.prefixListActionAvatarFavoriteId.idConcatenation(row),
                                                titleLableId: self.prefixTitleLabelId.idConcatenation(row),
                                                primaryButtonId: self.prefixPrimaryButtonId.idConcatenation(row),
                                                secondaryButtonId: self.prefixSecondaryButtonId.idConcatenation(row))
            }
            
            return cell
        case .listActionIconValue(let viewModels):
            let viewModel = viewModels[indexPath.row]
            let isShowBottomLine = indexPath.row != viewModels.count - 1
            
            let cell: DSListActionIconValueTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            let backgroundView = UIView()
            backgroundView.backgroundColor = DSColor.componentLightBackgroundOnPress
            cell.selectedBackgroundView = backgroundView
            cell.configure(viewModel: viewModel, isShowBottomLine: isShowBottomLine)
            
            // Set accessibility identifier for each DSListActionIconValue
            if self.prefixListActionIconValueId.isNotEmpty {
                cell.setAccessibilityIdentifier(id: self.prefixListActionIconValueId.idConcatenation(row),
                                                titleLabelId: self.prefixTitleLabelId.idConcatenation(row),
                                                valueLabelId: self.prefixValueLabelId.idConcatenation(row),
                                                descriptionLabelId: self.prefixDescriptionLabelId.idConcatenation(row))
            }
            
            return cell
        default:
            fatalError("UITableViewCell is not implement")
        }
    }
}

// MARK: - UITableViewDelegate
extension DSListActionView: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        delegate?.listActionView(self, didSelectRowAt: indexPath.row)
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

extension DSListActionView: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        delegate?.listActionView(self, didScroll: offset)
    }
}

// MARK: - Private
private extension DSListActionView {
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DSListActionIconTableViewCell.self)
        tableView.register(DSListActionIconSpotTableViewCell.self)
        tableView.register(DSListActionToggleTableViewCell.self)
        tableView.register(DSListActionMenuTableViewCell.self)
        tableView.register(DSListActionAvatarTableViewCell.self)
        tableView.register(DSListActionIconValueTableViewCell.self)
    }
}

// MARK: - DSToggleDelegate
extension DSListActionView: DSToggleDelegate {
    public func onToggle(tagId: Int, state: DSToggleState) {
        toggleDelegate?.listActionToggleView(index: tagId, withState: state)
    }
}

// MARK: - DSListActionAvatarTableViewCellDelegate
extension DSListActionView: DSListActionAvatarTableViewCellDelegate {
    func listActionAvatarTableViewCell(_ view: DSListActionAvatarTableViewCell,
                                       didSelectFavoriteAt index: Int,
                                       style: DSClickableIconFavoriteStyle) {
        avatarFavoriteDelegate?.listActionAvatarFavoriteView(self,
                                                             didSelectFavoriteAt: index,
                                                             style: style)
    }
    
    func listActionAvatarTableViewCell(_ view: DSListActionAvatarTableViewCell,
                                       didSelectPrimaryButtonAt index: Int) {
        avaterGhostDelegate?.listActionAvatarTableViewCell(self,
                                                           didSelectPrimaryButtonAt: index)
    }
    
    func listActionAvatarTableViewCell(_ view: DSListActionAvatarTableViewCell,
                                       didSelectSecondaryButtonAt index: Int) {
        avaterGhostDelegate?.listActionAvatarTableViewCell(self,
                                                           didSelectSecondaryButtonAt: index)
    }
}
