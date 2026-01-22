/**
 * Core Domain Models
 */
export interface StockItem {
    id: string; // UUID
    title: string;
    sku_info: string;
    last_updated: string; // ISO 8601 Timestamp
}

export interface AuthState {
    isLoggedIn: boolean;
    sessionToken: string | null;
}

export interface HardwareCache {
    capturedImage: string | null; // Base64 or Blob URL
    scannedCode: string | null;
}

/**
 * Global Application State Model
 */
export interface InventoryAppState {
    auth: AuthState;
    inventory: {
        items: StockItem[];
        lastSyncTimestamp: number;
        isLoading: boolean;
        error: string | null;
    };
    hardware: HardwareCache;
}

/**
 * UI Event Types for the State Machine
 */
export type InventoryEvent =
    | { type: 'APP_LOAD' }
    | { type: 'AUTH_SUCCESS' }
    | { type: 'FETCH_START' }
    | { type: 'FETCH_SUCCESS'; payload: StockItem[] }
    | { type: 'SEARCH_TRIGGERED'; query: string }
    | { type: 'HARDWARE_ACTION'; service: 'Camera' | 'BarcodeScanner' }
    | { type: 'DELETE_REQUESTED'; itemId: string };