import { Mail } from "lucide-react";


export default function Footer() {
    return (
        <footer className="flex justify-center items-center relative z-40 mt-30">
            <div className="grid grid-cols-2 lg:grid-cols-5 gap-4 max-w-7xl w-full px-4 py-10 border-t border-border">
                <div className="flex flex-col gap-2 col-span-2 mb-8 lg:mb-0">
                    <div className="flex flex-col gap-2">
                        <a className="flex items-center gap-4" href="/">
                            <img className="size-8" src="/neodlp.svg" alt="neodlp" />
                            <h5 className="text-2xl font-bold">NeoDLP</h5>
                        </a>
                        <p className="text-sm text-muted-foreground">The Next-Gen Cross-Platform Video Downloader</p>
                        <p className="text-sm mt-1">NeoDLP &copy; {new Date().getFullYear()} - All Rights Reserved &#8226; <a className="hover:underline" href="https://github.com/neosubhamoy/neodlp/blob/main/LICENSE" target="_blank">MIT License</a></p>
                    </div>
                    <div className="flex flex-col gap-2">
                        <a className="flex items-center text-xs text-muted-foreground hover:underline" href="mailto:support@neodlp.neosubhamoy.com">
                            <Mail className="size-4" />
                            <span className="ml-2 pb-[0.15rem]">support@neodlp.neosubhamoy.com</span>
                        </a>
                    </div>
                </div>
                <div className="flex flex-col gap-2">
                    <h5 className="font-semibold mb-2">Terms</h5>
                    <a className="text-sm text-muted-foreground hover:underline" href="/privacy-policy">Privacy Policy</a>
                    <a className="text-sm text-muted-foreground hover:underline" href="/terms-of-use">Terms Of Use</a>
                    <a className="text-sm text-muted-foreground hover:underline" href="/dmca">DMCA</a>
                </div>
                <div className="flex flex-col gap-2">
                    <h5 className="font-semibold mb-2">Sources</h5>
                    <a className="text-sm text-muted-foreground hover:underline" href="https://github.com/neosubhamoy/neodlp" target="_blank">NeoDLP</a>
                    <a className="text-sm text-muted-foreground hover:underline" href="https://github.com/neosubhamoy/neodlp-extension" target="_blank">NeoDLP Extension</a>
                </div>
                <div className="flex flex-col gap-2">
                    <h5 className="font-semibold mb-2">More Products from Us</h5>
                    <a className="text-sm text-muted-foreground hover:underline" href="https://github.com/neosubhamoy/pytubepp" target="_blank">PytubePP</a>
                    <a className="text-sm text-muted-foreground hover:underline" href="https://prourl.eu.org" target="_blank">ProURL</a>
                </div>
            </div>
        </footer>
    );
}