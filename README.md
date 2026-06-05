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

## Setup

### 1. Host the Notebook

Upload `NamOS_Trainer.ipynb` to a GitHub repository. Then update the Colab link in `netlify/index.html`:

```html
<!-- Replace this line in netlify/index.html -->
href="https://colab.research.google.com/github/YOUR_USERNAME/YOUR_REPO/blob/main/NamOS_Trainer.ipynb"
```

### 2. Deploy Landing Page

**Option A: Netlify Drop (easiest)**
1. Go to [netlify.com/drop](https://netlify.com/drop)
2. Drag the `netlify/` folder onto the page
3. Get a live URL instantly

**Option B: GitHub + Netlify**
1. Push the `netlify/` folder to a GitHub repo
2. Connect the repo to Netlify
3. Auto-deploy on every push

### 3. Using the Notebook

1. Click "Open in Google Colab"
2. Runtime → Change runtime type → GPU (T4 recommended)
3. Run cells in order:
   - Install dependencies
   - Upload DI, pre-trained .nam models, and capture .wav files
   - Adjust hyperparameters
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

## Output

- `.namos` files in `output/` folder
- Zipped download: `NamOS_models.zip`

## Notes

- Models are matched by filename stem (without `_in_X_out_Y` suffix)
- Training uses GPU if available (T4 on Colab free tier)
- Each model is trained independently (batch processing)
