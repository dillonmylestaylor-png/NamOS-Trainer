# NamOS Trainer

Multi-rate conditioning trainer for NAM (Neural Amp Modeler) models.

## What It Does

- Takes pre-trained 1-channel `.nam` models
- Expands them to 2-channel (audio + sample rate conditioning)
- Fine-tunes at 96kHz and 192kHz for better high-sample-rate performance
- Exports `.namos` files (NamOS format)

## Files

- **`NamOS_Trainer.ipynb`** — Google Colab notebook with interactive training
- **`netlify/`** — Static landing page for Netlify deployment
- **`setup.sh`** — One-click setup script

## Quick Setup (2 Steps)

### 1. Deploy to Netlify

1. Go to [netlify.com/drop](https://netlify.com/drop)
2. Drag the `netlify/` folder onto the page
3. Get a live URL instantly

**Or for auto-deploy:**
1. Sign up at [netlify.com](https://netlify.com)
2. "Add new site" → "Deploy manually"
3. Drag the `netlify/` folder onto the page

### 2. (Optional) Make the GitHub repo private

The trainer notebook is hosted on Google Drive. The GitHub repo is only for the landing page.

If you want to hide the source code:
1. Go to https://github.com/dillonmylestaylor-png/NamOS-Trainer/settings
2. Scroll down to "Danger Zone" → "Change repository visibility"
3. Click "Change to private"

## Using the Notebook

1. Click "Open in Google Colab" from the landing page
2. Runtime → Change runtime type → GPU (T4 recommended)
3. Run cells in order:
   - Install dependencies
   - Upload DI, pre-trained .nam models, and capture .wav files
   - Adjust hyperparameters (sliders)
   - Train
   - Download results

## Required Files

- **DI** (`input.wav`) — Dry input signal used for all captures
- **Pre-trained models** (`.nam`) — Standard NAM WaveNet models
- **Captures** (`.wav`) — Reamp recordings matching each model

## Hyperparameters

| Parameter | Default | Description |
|-----------|---------|-------------|
| Epochs | 200 | Training iterations per model |
| Patience | 30 | Early stopping patience (epochs) |
| Learning Rate | 0.0001 | Adam optimizer learning rate |
| Batch Size | 64 | Samples per batch |
| Chunk Size | 8192 | Audio samples per training chunk |
| Val Frequency | 5 | Validate every N epochs |

## Custom Domain (Optional)

**Yes, you can add a custom domain later.**

1. Go to Netlify → Site settings → Domain management
2. Click "Add custom domain"
3. Enter your domain (e.g., `trainer.tonkraf.com`)
4. Netlify gives you DNS records to add at your domain registrar
5. Or use Netlify DNS (easier) — just change your domain's nameservers to Netlify's

**Costs:**
- Netlify free tier: $0
- Custom domain: ~$10-15/year (Namecheap, Cloudflare, etc.)
- Netlify doesn't charge for custom domains on free tier

## Output

- `.namos` files in `output/` folder
- Zipped download: `NamOS_models.zip`

## Notes

- Models are matched by filename stem (without `_in_X_out_Y` suffix)
- Training uses GPU if available (T4 on Colab free tier)
- Each model is trained independently (batch processing)
- The Phoenix plugin will eventually support `.namos` files

## Support

Made by [Tonkraf](https://www.tonkraf.com) · Built on [NAM](https://github.com/sdatkinson/NeuralAmpModeler)
