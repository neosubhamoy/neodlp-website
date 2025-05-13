export interface LatestRelease {
    version: string;
    notes: string;
    pub_date: string;
    platforms: {
        [key: string]: {
            signature: string;
            url: string;
        };
    }
}

export interface LatestExtensionRelease {
    version: string;
    notes: string;
    browsers: {
        [key: string]: {
            url: string;
        };
    };
}