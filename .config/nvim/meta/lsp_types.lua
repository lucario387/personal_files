---@meta

---@class ExecuteCommandParams
---@field command string Identifier of the actual command header
---@field arguments LSPAny[] Arguments that the actual command should be invoked with

---@alias decimal number
---@alias LSPObject table<string,any>
---@alias LSPArray LSPAny[]
---@alias LSPAny LSPObject|LSPArray|string|integer|decimal|boolean|nil

---@class WorkspaceEditClientCapabilities
---@field documentChanges? boolean
---@field resourceOperations? ResourceOperationKind[]
---@field failureHandling? FailureHandlingKind
---@field normalizesLineEndings? boolean
---@field changeAnnotationSupport? { groupsOnLabel?: boolean }

---@alias ResourceOperationKind 'create'|'rename'|'delete'
---@alias FailureHandlingKind 'abort'|'transactional'|'undo'|'textOnlyTransactional'

---@class DidChangeConfigurationClientCapabilties
---@field dynamicRegistration? boolean

---@class DidChangedWatchFilesClientCapabilities
---@field dynamicRegistration? boolean
---@field relativePatternSupport? boolean

---@class WorkspaceSymbolClientCapabilities
---@field dynamicRegistration? boolean
---@field symbolKind? {valueSet: SymbolKind[]}
---@field tagSupport? {valueSet: SymbolTag[]}
---@field resolveSupport? {properties: string[]}

---@class ExecuteCommandClientCapabilities
---@field dynamicRegistration? boolean

---@class SemanticTokensWorkspaceClientCapabilities
---@field refreshSupport? boolean

---@class CodeLensWorkspaceClientCapabilties
---@field refreshSupport? boolean

---@class FileOperationsCapabilities
---@field dynamicRegistration boolean?
---@field didCreate boolean?
---@field willCreate boolean?
---@field didRename boolean?
---@field willRename boolean?
---@field didDelete boolean?
---@field willDelete boolean?

---@class InlineValueWorkspaceClientCapabilities
---@field refreshSupport? boolean

---@class InlayHintWorkspaceClientCapabilities
---@field dynamicRegistration? boolean
---@field resolveSupport? {properties: string[]}

---@class DiagnosticsWorkspaceClientCapabilities
---@field refreshSupport? boolean

---@class WorkspaceClientCapabilities
---@field applyEdit? boolean
---@field workspaceEdit? WorkspaceEditClientCapabilities
---@field didChangeConfiguration? DidChangeConfigurationClientCapabilties
---@field didChangeWatchFiles? DidChangedWatchFilesClientCapabilities
---@field symbol? WorkspaceSymbolClientCapabilities
---@field executeCommand? ExecuteCommandClientCapabilities
---@field workspaceFolders? boolean
---@field configuration? boolean
---@field semanticTokens? SemanticTokensWorkspaceClientCapabilities
---@field codeLens? CodeLensWorkspaceClientCapabilties
---@field fileOperations? FileOperationsCapabilities
---@field inlineValue? InlineValueWorkspaceClientCapabilities
---@field inlayHint? InlayHintWorkspaceClientCapabilities
---@field diagnostics? DiagnosticsWorkspaceClientCapabilities

---@class TextDocumentSyncClientCapabilities

---@class CompletionClientCapabilities

---@class HoverClientCapabilities

---@class SignatureHelpClientCapabilities

---@class DeclarationClientCapabilities

---@class DefinitionClientCapabilities

---@class TypeDefinitionClientCapabilities

---@class ImplementationClientCapabilities

---@class ReferencesClientCapabilities

---@class DocumentHighlightClientCapabilities

---@class DocumentSymbolClientCapabilities

---@class CodeActionClientCapabilities

---@class CodeLensClientCapabilities

---@class DocumentLinkClientCapabilities

---@class DocumentColorClientCapabilities

---@class DocumentFormattingClientCapabilities

---@class DocumentRangeFormattingClientCapabilities

---@class DocumentOnTypeFormattingClientCapabilities

---@class RenameClientCapabilities

---@class PublishDiagnosticsClientCapabilities

---@class FoldingRangeClientCapabilities

---@class SelectionRangeClientCapabilities

---@class LinkedEditingRangeClientCapabilities

---@class SemanticTokensClientCapabilities

---@class MonikerClientCapabilities

---@class TypeHierarchyClientCapabilities

---@class InlineValueClientCapabilities

---@class InlayHintClientCapabilities

---@class DiagnosticClientCapabilities

---@class TextDocumentClientCapabilities
---@field synchronization? TextDocumentSyncClientCapabilities
---@field completion? CompletionClientCapabilities
---@field hover? HoverClientCapabilities
---@field signatureHelp? SignatureHelpClientCapabilities
---@field declaration? DeclarationClientCapabilities
---@field definition? DefinitionClientCapabilities
---@field typeDefinition? TypeDefinitionClientCapabilities
---@field implementation? ImplementationClientCapabilities
---@field references? ReferencesClientCapabilities
---@field documentHighlight? DocumentHighlightClientCapabilities
---@field documentSymbol? DocumentSymbolClientCapabilities
---@field codeAction? CodeActionClientCapabilities
---@field codeLens? CodeLensClientCapabilities
---@field documentLink? DocumentLinkClientCapabilities
---@field colorProvider? DocumentColorClientCapabilities
---@field formatting? DocumentFormattingClientCapabilities
---@field rangeFormatting? DocumentRangeFormattingClientCapabilities
---@field onTypeFormatting? DocumentOnTypeFormattingClientCapabilities
---@field rename? RenameClientCapabilities
---@field publishDiagnostics? PublishDiagnosticsClientCapabilities
---@field foldingRange? FoldingRangeClientCapabilities
---@field selectionRange? SelectionRangeClientCapabilities
---@field linkedEditingRange? LinkedEditingRangeClientCapabilities
---@field semanticTokens? SemanticTokensClientCapabilities
---@field moniker? MonikerClientCapabilities
---@field typeHierarchy? TypeHierarchyClientCapabilities
---@field inlineValue? InlineValueClientCapabilities
---@field inlayHint? InlayHintClientCapabilities
---@field diagnostic? DiagnosticClientCapabilities

---@class NotebookDocumentClientCapabilities

---@class WindowClientCapabilities
---@field workDoneProgress? boolean
---@field showMessage? ShowMessageRequestClientCapabilities
---@field showDocument? ShowDocumentClientCapabilities

---@alias ShowMessageRequestClientCapabilities {messageActionItem?: {additionalPropertiesSupport?: boolean}}
---@alias ShowDocumentClientCapabilities {support: boolean}

---@class GeneralClientCapabilities

---@class ClientCapabilities
---@field workspace? WorkspaceClientCapabilities
---@field textDocument? TextDocumentClientCapabilities
---@field notebookDocument? NotebookDocumentClientCapabilities
---@field window? WindowClientCapabilities
---@field general GeneralClientCapabilities
